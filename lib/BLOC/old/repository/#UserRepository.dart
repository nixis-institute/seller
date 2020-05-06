import 'package:meta/meta.dart';
import 'package:shopping_junction_seller/functions/common.dart';
import 'package:shopping_junction_seller/functions/requestLogin.dart';
class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    // await Future.delayed(Duration(seconds: 1));
    if(await requestLoginApi(username,password)!=null)
    {
      return await requestLoginApi(username,password);
    }
    else{
      return null;
    }
    // return 'token';
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    // await Future.delayed(Duration(seconds: 1));
    deleteT();
    return;
  }

  Future<void> persistToken(String token) async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    return await getTotal();
  }
}