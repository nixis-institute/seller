
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_junction_seller/Graphql/Queries.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';

class LoginRepostory{
  GraphQLClient client = clientToQuery();


  Future<bool> hasToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // print(preferences.getString("LastToken"));
    // return true;
    return preferences.getString("LastToken").length==0?false:true;
  }


  setToken(token) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("LastToken", token); 
  }

  removeToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("LastToken", "");
  }

  login(username,password) async{
    QueryResult result = await client.mutate(
      MutationOptions(
        documentNode: gql(getTokenQuery),
        variables: {
          "username":username,
          "password":password
        }
      )
    );

    if(!result.hasException){
      var token = result.data["tokenAuth"]["token"];
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("LastToken", token);
      return token;
    }
  }

}