import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
// import 'package:shopping_junction_seller/BLOC/subproducts_bloc/subproduct_repository.dart';
import 'package:shopping_junction_seller/Graphql/Queries.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/models/productModel.dart';
import 'repositories.dart';
part 'subproduct_event.dart';
part 'subproduct_state.dart';

class SubproductBloc extends Bloc<SubproductEvent, SubproductState> {
  final SubProductRepository repository;
  SubproductBloc({this.repository});
  GraphQLClient client = clientToQuery();
  List<SubProductModel> _allproducts =[];
  @override
  SubproductState get initialState => SubproductInitial();

  @override
  Stream<SubproductState> mapEventToState(SubproductEvent event,) async* {
    var currentState = state;
    if(event is OnSubProducts){
      yield* _mapSubProductLoadedToState(event,currentState);
    }
    if(event is OnAddSubProductColor){
      if(currentState is LoadSubProduct){
        final product = await repository.createProduct(event.id,event.size,event.color,event.qty,event.mrp,event.listPrice);

        final List<SubProductModel> prd= 
        (currentState as LoadSubProduct).products..map((p) {
            return p.size == product.size?p.product.add(product.product[0]):p.product.map((e) =>  e).toList();
        } ).toList();      
        yield LoadSubProduct(products: prd,sizes: currentState.sizes);
        // yield NavigationPop();
      }
    }

    if(event is OnAddSubProduct){
      if(currentState is LoadSubProduct){

        List<String> _totalSizes =[];
        sizePicker.forEach((k,v)=>{
          _totalSizes.add(k)
        });

        final product = await repository.createProduct(event.id,event.size,event.color,event.qty,event.mrp,event.listPrice);
        _totalSizes.remove(event.size);
        // final product = List<SubProductModel>.from(state);
        
        yield LoadSubProduct(products: [...currentState.products,product] ,sizes:  _totalSizes );

        // yield* _mapSubProductAddedToState(event);
      }
      
    }
    if(event is OnUpdateSubProductImages){
      if(currentState is LoadSubProduct){
        
        final List<SubProductModel> prd= 
        (currentState as LoadSubProduct).products..map((product) {
           return product.product.map((p){
             return p.id == event.product.id?event.product:p;
           }).toList();
        } ).toList();
        // yield NavigationPop();
        yield LoadSubProduct(products: prd,sizes: currentState.sizes);
      }
    }

    // TODO: implement mapEventToState
  }

  Stream <SubproductState> _mapSubProductAddedToState(event) async*{
        // yield SubProductsLoading();
        List<String> _totalSizes =[];
        sizePicker.forEach((k,v)=>{
          _totalSizes.add(k)
        });

        final product = await repository.createProduct(event.id,event.size,event.color,event.qty,event.mrp,event.listPrice);
        _totalSizes.remove(event.size);
        // final product = List<SubProductModel>.from(state);
        
        yield LoadSubProduct(products: [...(state as LoadSubProduct).products,product] ,sizes:  _totalSizes );
  
  }

  Stream<SubproductState> _mapSubProductLoadedToState(event,state) async* {
      try{
        // print("lad");
        yield SubProductsLoading();        
        // print("ding");
        List<String> _totalSizes=[];
        sizePicker.forEach((k,v)=>{
          _totalSizes.add(k)
        });

          final product  = await repository.getSubProductByRepository(event.id);
          product.forEach((element) =>{
          _totalSizes.contains(element.size)==true?_totalSizes.remove(element.size):null
          });
          yield LoadSubProduct(products: product,sizes: _totalSizes);
          
        // if(state is SubproductInitial)
        // {
        //   final product  = await repository.getSubProductByRepository(event.id);
        //   product.forEach((element) =>{
        //   _totalSizes.contains(element.size)==true?_totalSizes.remove(element.size):null
        //   });
        //   yield LoadSubProduct(products: product,sizes: _totalSizes);
        // }

        // if(state is LoadSubProduct)
        //   {
        //   final product  = await repository.getSubProductByRepository(event.id);
        //   product.forEach((element) =>{
        //   _totalSizes.contains(element.size)==true?_totalSizes.remove(element.size):null
        //   });
        //   yield LoadSubProduct(products: product,sizes: _totalSizes);
        // }

        // print(product);



      }
      catch(_){
        yield FailureSubProduct();
      }


       
  }



  // Future<SubProductModel> createProduct(id,size,color,qty,mrp,list) async{
  //   QueryResult result = await client.mutate(
  //     MutationOptions(
  //       documentNode: gql(createSubProductQuery),
  //       variables: {
  //         "id":id,
  //         "mrp":mrp,
  //         "list":list,
  //         "color":color,
  //         "size":size,
  //         "qty":qty
  //       }
  //     )
  //   );

  //   if(!result.hasException){
  //     var data = result.data["createSubProduct"]["subProduct"];
  //     SubProductModel prd;
  //     // prd.size = size;

  //     prd = SubProductModel(
  //       size: size,
  //       product: [
  //       SubProduct(id, 
  //       "", 
  //       double.parse(list), 
  //       double.parse(mrp), 
  //       false, 
  //       int.parse(qty), 
  //       [], 
  //       size, 
  //       color)
  //       ]
  //     );

  //     // prd.product.add(
  //     //   SubProduct(id, 
  //     //   "", 
  //     //   list, 
  //     //   mrp, 
  //     //   false, 
  //     //   qty, 
  //     //   [], 
  //     //   size, 
  //     //   color)
  //     // );
  //     return prd;
  //   }
  // }


  //   Future<List<SubProductModel>> getSubProductByRepository(id) async{
  //     print("getproducts");
  //     QueryResult result = await client.query(
  //       QueryOptions(
  //         documentNode: gql(getProductByParentId),
  //         variables: {
  //           "id":id
  //         }
  //       )
  //     );
  //     if(!result.hasException)
  //     {
  //       var data = result.data["productByParentId"]["edges"];
  //       List<SubProduct> prd=[];
  //       List<ProductImage> img=[];
        
  //       List<SubProductModel> prdModelList=[];
  //       // SubProductModel p = new SubProductModel();

  //       Map e = new Map();
  //       // SubProductModel
        
  //       for(int i=0;i<data.length;i++)
  //       {
  //         img=[];
  //         data[i]["node"]["productimagesSet"]["edges"].forEach((e)=>{
  //             img.add(
  //               ProductImage(
  //                 e["node"]["id"],
  //                 e["node"]["largeImage"], 
  //                 e["node"]["normalImage"], 
  //                 e["node"]["thumbnailImage"]
                  
  //                 )
  //             )
  //         });

  //         // prd.add(
  //         //   SubProduct(data[i]["node"]["id"], 
  //         //   "", 
  //         //   data[i]["node"]["listPrice"], 
  //         //   data[i]["node"]["mrp"],
  //         //   data[i]["node"]["instock"], 
  //         //   data[i]["node"]["qty"],
  //         //   img,
  //         //   data[i]["node"]["size"], 
  //         //   data[i]["node"]["color"])
  //         // );

  //         if(e.containsKey(data[i]["node"]["size"]))
  //         {
  //           e[data[i]["node"]["size"]].add(
  //             SubProduct(data[i]["node"]["id"], 
  //             "", 
  //             data[i]["node"]["listPrice"], 
  //             data[i]["node"]["mrp"],
  //             data[i]["node"]["instock"], 
  //             data[i]["node"]["qty"],
  //             img,
  //             data[i]["node"]["size"], 
  //             data[i]["node"]["color"])
  //           );
  //         }
  //         else{
  //           e[data[i]["node"]["size"]] = [
  //             SubProduct(data[i]["node"]["id"], 
  //             "", 
  //             data[i]["node"]["listPrice"], 
  //             data[i]["node"]["mrp"],
  //             data[i]["node"]["instock"], 
  //             data[i]["node"]["qty"],
  //             img,
  //             data[i]["node"]["size"], 
  //             data[i]["node"]["color"])
  //           ];
  //         }

  //         // if(p.size.isEmpty || p.size !=data[i]["node"]["size"])
  //         // {
  //         //   p.size = data[i]["node"]["size"];
  //         // }
  //         // else
  //       }

  //       e.forEach((key,value)=>{
  //         prdModelList.add(
  //           SubProductModel(
  //             size: key,
  //             product: value
  //           )
  //         )
  //       });
  //       // subProductListRepository = prdModelList;
  //       // print(prdModelList[0].product);
  //       return prdModelList;
  //     }
  // }

}
