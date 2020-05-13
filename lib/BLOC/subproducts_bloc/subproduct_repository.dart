import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction_seller/Graphql/Queries.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/models/productModel.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

class SubProductRepository{

  // Future<String> l =  _prd();

  // List<SubProductModel> subProductListRepository = [];
  
  List<SubProductModel> _allproducts =[];

  GraphQLClient client = clientToQuery();


  Future<List<SubProductModel>> getSubProductByRepository(String id) async {

    try{
      QueryResult result = await client.query(
        QueryOptions(
          documentNode: gql(getProductByParentId),
          variables: {
            "id":id
          },
          fetchPolicy: FetchPolicy.cacheAndNetwork
        )
      );
      
      
      // print("reslt");
      //fetch source 1 for cahche: QueryResultSource.Cache
      //3 for network: QueryResultSource.Network
      //
      print(result.source.toString());
      print(result.source.index);

        var data = result.data["productByParentId"]["edges"];
        List<ProductImage> img=[];
        
        List<SubProductModel> prdModelList=[];
        Map e = new Map();
        for(int i=0;i<data.length;i++)
        {
          img=[];
          data[i]["node"]["productimagesSet"]["edges"].forEach((e)=>{
              img.add(
                ProductImage(
                  e["node"]["id"],
                  e["node"]["largeImage"], 
                  e["node"]["normalImage"], 
                  e["node"]["thumbnailImage"]
                  
                  )
              )
          });

          if(e.containsKey(data[i]["node"]["size"]))
          {
            e[data[i]["node"]["size"]].add(
              SubProduct(data[i]["node"]["id"], 
              "", 
              data[i]["node"]["listPrice"], 
              data[i]["node"]["mrp"],
              data[i]["node"]["instock"], 
              data[i]["node"]["qty"],
              img,
              data[i]["node"]["size"], 
              data[i]["node"]["color"])
            );
          }
          else{
            e[data[i]["node"]["size"]] = [
              SubProduct(data[i]["node"]["id"], 
              "", 
              data[i]["node"]["listPrice"], 
              data[i]["node"]["mrp"],
              data[i]["node"]["instock"], 
              data[i]["node"]["qty"],
              img,
              data[i]["node"]["size"], 
              data[i]["node"]["color"])
            ];
          }

        }

        e.forEach((key,value)=>{
          prdModelList.add(
            SubProductModel(
              size: key,
              product: value
            )
          )
        });
        // subProductListRepository = prdModelList;
        // print(prdModelList[0].product);
        // _allproducts = prdModelList;
        // return prdModelList;
        // print(_allproducts);
        // return _allproducts;
        return prdModelList;
    }
    catch(e){
      print("errorroror");
    }
  }


    Future<SubProductModel> createProduct(id,size,color,qty,mrp,list) async{
    QueryResult result = await client.mutate(
      MutationOptions(
        documentNode: gql(createSubProductQuery),
        variables: {
          "id":id,
          "mrp":mrp,
          "list":list,
          "color":color,
          "size":size,
          "qty":qty
        },
        update: (cache, result) {
          // print("Cahce..."+ cache.read(<>));
          // cache.write(typenameDataIdFromObject, value)
        },
      )
    );
  

    if(!result.hasException){
      var data = result.data["createSubProduct"]["subProduct"];
      SubProductModel prd;
      // prd.size = size;

      prd = SubProductModel(
        size: size,
        product: [
        SubProduct(id, 
        "", 
        double.parse(list), 
        double.parse(mrp), 
        false, 
        int.parse(qty), 
        [], 
        size, 
        color)
        ]
      );
      // _allproducts.add(prd);
      // return prd;
      return prd;
    }
  }





}