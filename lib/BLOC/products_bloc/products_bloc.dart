import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:shopping_junction_seller/Graphql/Queries.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/models/productModel.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  GraphQLClient client = clientToQuery();
  @override
  ProductsState get initialState => ProductsInitial();

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event,) async* {
  
    if(event is OnMainCategory)
    {
      // print("category....");
      yield ProductsLoading();
      final category = await _fetchMainCategory();
      // print("loaded...");
      yield LoadCateogry(categories: category);
      return;
    }

    if(event is OnSubCategory)
    {
      // yield ProductLoading();
      yield ProductsLoading();
      final category = await _fetchSubCategory(event.id);
      yield LoadSubCategory(subcategories: category);
      // yield LoadSubCateogry(subcategories: category);
      return;
    }
  }









  Future<List<Category>> _fetchMainCategory() async{
      QueryResult result = await client.query(
        QueryOptions(
          documentNode: gql(getCategoryQuery)
        )
      );

      if(!result.hasException){
        var data = result.data["allCategory"]["edges"];
        List<Category> category = [];
        for(int i=0;i<data.length;i++)
        {
          category.add(
            Category(
               data[i]["node"]["id"], 
               data[i]["node"]["name"], 
               data[i]["node"]["image"]
               )
          );
        }
        return category;
      }
  }

  Future<List<ProductSubCategory>> _fetchSubCategory(id) async{
      QueryResult result = await client.query(
        QueryOptions(
          documentNode: gql(getSubCategoryQuery),
          variables: {
            "CateogryId":id
          }
        )
      );

      if(!result.hasException){
        var data = result.data["subcateogryByCategoryId"]["edges"];
        List<ProductSubCategory> category = [];
        for(int i=0;i<data.length;i++)
        {
          category.add(
            ProductSubCategory(
            data[i]["node"]["id"], 
            data[i]["node"]["name"])
          );
        }
        return category;
      }
  }



}
