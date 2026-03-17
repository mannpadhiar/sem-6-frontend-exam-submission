import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/local_data.dart';
import 'auth_api.dart';

Future<Map<String, dynamic>> addUsers(Map<String,dynamic> user) async{
  try{
    final bearerToken = await getToken();

    final res = await http.post(Uri.parse("$baseUrl/admin/users"),
      headers: {
        'Content-Type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization' : "Bearer $bearerToken"
      },
      body: json.encode(user),
    );

    if(res.statusCode == 200){
      return json.decode(res.body);
    }
    else{
      print("there is some error in users ${res.body}");
      return json.decode(res.body);
    }
  }catch(e){
    print("Error POST /admin/users : " + e.toString());
    return {};
  }
}

Future<List<dynamic>> getUsers() async{
  try{
    final bearerToken = await getToken();

    final res = await http.get(Uri.parse("$baseUrl/admin/users"),
      headers: {
        'Content-Type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization' : "Bearer $bearerToken"
      },
    );

    if(res.statusCode == 200){
      return json.decode(res.body);
    }
    else{
      print("there is some error in admin-users");
      return [];
    }
  }catch(e){
    print("Error Get /admin/users : " + e.toString());
    return [];
  }
}

Future<Map<String, dynamic>> getClinicInfo() async{
  try{
    final bearerToken = await getToken();

    final res = await http.get(Uri.parse("$baseUrl/admin/clinic"),
      headers: {
        'Content-Type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization' : "Bearer $bearerToken"
      },
    );

    if(res.statusCode == 200){
      return json.decode(res.body);
    }
    else{
      print("there is some error in admin-clinic");
      return {};
    }
  }catch(e){
    print("Error POST /admin/clinic : " + e.toString());
    return {};
  }
}