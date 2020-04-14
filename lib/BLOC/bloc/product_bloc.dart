import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction_seller/Graphql/Queries.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/models/productModel.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  GraphQLClient client = clientToQuery();
  

  @override
  ProductState get initialState => ProductInitial();

  // get products => null;

  @override
  Stream<ProductState> mapEventToState(ProductEvent event,) async* {
    // TODO: implement mapEventToState
    // if(state is ProductInitial)
    // if(event is AppStarted)
    // {
    //   yield ProductLoaded();
    // }

    if(event is AppStarted){
      yield ProductLoading();
      
      final products = await _fetchProducts();
      yield ProductLoaded(products: products);
      return;
      // yield FetchProduct();


      // if(state is ProductInitial)
      // // if(state is ProductLoaded){
      //     yield ProductLoading();
      // }
    }
  }

  Future<List<Product>> _fetchProducts() async{
      QueryResult result = await client.query(
        QueryOptions(
          documentNode: gql(getProductsQuery)
        )
      );

      if(!result.hasException){
        List data = result.data["allProducts"]["edges"];
        List<Product> _prd = [];
        if(data.isEmpty){
          return _prd;
        }
        else{
          for(int i=0;i<data.length;i++)
          {
            _prd.add(
              Product(data[i]["node"]["id"], data[i]["node"]["name"], data[i]["node"]["listPrice"],data[i]["node"]["mrp"], [])
            );
          }
        }
        return _prd;
      }
      
  }
}
