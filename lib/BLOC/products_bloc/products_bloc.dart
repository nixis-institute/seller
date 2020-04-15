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
    
    if(event is OnProductType)
    {
      yield ProductsLoading();
      final productType = await _fetchTypeProduct(event.id);
      yield LoadTypeProduct(productType: productType);

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

    if(event is OnProducts)
    {
      yield ProductsLoading();
      print(event.id);
      final products = await _fetcheProducts(event.id);
      print(event.id);
      yield LoadProducts(products: products);
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



  Future<List<TypeProduct>> _fetchTypeProduct(id) async{
      QueryResult result = await client.query(
        QueryOptions(
          documentNode: gql(getTypeProductQuery),
          variables: {
            "id":id
          }
        )
      );

      if(!result.hasException){
        var data = result.data["sublistBySubcategoryId"]["edges"];
        List<TypeProduct> category = [];
        for(int i=0;i<data.length;i++)
        {
          category.add(
            TypeProduct(
            data[i]["node"]["id"], 
            data[i]["node"]["name"])
          );
        }
        return category;
      }
  }


    Future<List<Product>> _fetcheProducts(id) async{
      QueryResult result = await client.query(
        QueryOptions(
          documentNode: gql(getProductByTypeId),
          variables: {
            "id":id
          }
        )
      );

      if(!result.hasException){
        var data = result.data["productBySublistId"]["edges"];
        List<Product> products = [];
        for(int i=0;i<data.length;i++)
        {
          print(data[i]["node"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]);
          products.add(
            Product(
              data[i]["node"]["id"], 
              data[i]["node"]["name"], 
              0, 
              0, 
              !data[i]["node"]["productimagesSet"]["edges"].isEmpty
              ?data[i]["node"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]:null
              
              // data[i]["node"]["productimagesSet"]["edges"]?data[i]["node"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]:null,
              )
            );
          //   TypeProduct(
          //   data[i]["node"]["id"], 
          //   data[i]["node"]["name"])
          // );
        }
        return products;
      }
  }


}
