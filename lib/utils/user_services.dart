import 'dart:convert';
import '../services/auth_api.dart';
import 'local_data.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> addUsers(Map<String,dynamic> user) async{
  try{
    final bearerToken = await getToken();

    final res = await http.post(Uri.parse("$baseUrl/users"),
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
      print("there is some error in users");
      return json.decode(res.body);
    }
  }catch(e){
    print("Error POST /restaurants : " + e.toString());
    return {};
  }
}