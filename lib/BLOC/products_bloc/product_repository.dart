import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction_seller/Graphql/Queries.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/models/productModel.dart';

class ProductRepository{

  // Future<String> l =  _prd();

  List<SubProductModel> subProductListRepository;


  GraphQLClient client = clientToQuery();
  Future<List<SubProductModel>> getSubProductByRepository(id) async{
      QueryResult result = await client.query(
        QueryOptions(
          documentNode: gql(getProductByParentId),
          variables: {
            "id":id
          }
        )
      );
      if(!result.hasException)
      {
        var data = result.data["productByParentId"]["edges"];
        List<SubProduct> prd=[];
        List<ProductImage> img=[];
        
        List<SubProductModel> prdModelList=[];
        // SubProductModel p = new SubProductModel();

        Map e = new Map();
        // SubProductModel
        
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

          // prd.add(
          //   SubProduct(data[i]["node"]["id"], 
          //   "", 
          //   data[i]["node"]["listPrice"], 
          //   data[i]["node"]["mrp"],
          //   data[i]["node"]["instock"], 
          //   data[i]["node"]["qty"],
          //   img,
          //   data[i]["node"]["size"], 
          //   data[i]["node"]["color"])
          // );

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

          // if(p.size.isEmpty || p.size !=data[i]["node"]["size"])
          // {
          //   p.size = data[i]["node"]["size"];
          // }
          // else
        }

        e.forEach((key,value)=>{
          prdModelList.add(
            SubProductModel(
              size: key,
              product: value
            )
          )
        });
        subProductListRepository = prdModelList;
        // print(prdModelList[0].product);
        return subProductListRepository;
      }
  }


}