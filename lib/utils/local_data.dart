import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> setToken(String token) async{
  try{
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("token", token);
  }catch(e){
    print("error adding token in local storage" + e.toString());
  }
}

Future<String> getToken() async{
  try{
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString("token");

    if(data == null){
      print("Local data is empty");
      return "";
    }

    return data;
  }catch(e){
    print("error getting token in local storage" + e.toString());
    return "";
  }
}