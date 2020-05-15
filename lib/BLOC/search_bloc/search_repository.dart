import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction_seller/Graphql/Queries.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/models/productModel.dart';

class SearchRepository{
  GraphQLClient _client = clientToQuery();
  
  Future<List<Product>> searcByCategory(search) async{

  }

  Future<List<Product>> searchProductBySubListId(String id) async{
    // productBySublistIdQuery
    // print(id);
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(productBySublistIdQuery),
        variables: {
          "id":id
        },
        fetchPolicy: FetchPolicy.networkOnly
      )
    );
    if(!result.hasException){
      List data = result.data["productBySublistId"]["edges"];
      List<Product> prd = [];
      data.forEach((e) { 
        prd.add(
          Product(
            e["node"]["id"], 
            e["node"]["brand"], 
            e["node"]["name"], 
            0, 
            e["node"]["productimagesSet"]["edges"].isNotEmpty?e["node"]["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]:"", 
            e["node"]["productSize"]
            )
        );
      });

      return prd;
    }
  }



  Future<List<Product>> searcByProduct(search) async{
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(searchByNameQuery),
        variables:{
          "match":search,
          }
      )
    );

    if(!result.hasException){
      List data = result.data["searchResult"];
      List<Product> prd = [];

      data.forEach((el) {
          prd.add(
            Product(el["id"], el["brand"], el["name"], 0, 
            
            el["productimagesSet"]["edges"].isNotEmpty?el["productimagesSet"]["edges"][0]["node"]["thumbnailImage"]:null,
            el["productSize"])
          );
      });
      return prd;
    }
  }

  Future<List<CategoryName>> searchByCategory(search) async{
// searchByCategoryQuery
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(searchByCategoryQuery),
        variables:{
          "match":search,
          }
      )
    );
    if(!result.hasException){
      List data = result.data["searchCategory"];
      List<CategoryName> cat = [];
      data.forEach((e) { 
        if(e["productSize"]>0){
            cat.add(
          CategoryName(
            e["id"],
            e["name"]+" in "+e["subCategory"]["mainCategory"]["name"],
            productSize: e["productSize"].toString()
          )
        );
        }
        
      });

      return cat;
    }

  }

}