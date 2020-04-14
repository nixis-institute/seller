import 'package:shared_preferences/shared_preferences.dart';
  Future<bool> getTotal() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("LastToken");
    // print("count_"+_count);
    if(id !=null)
    return true;
    else 
    return false;
  }

  Future<void> deleteT() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("LastToken");
    return;
  }