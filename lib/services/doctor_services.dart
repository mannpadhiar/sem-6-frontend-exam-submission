import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/local_data.dart';
import 'auth_api.dart';

Future<List<dynamic>> getDoctorQueue() async{
  try{
    final bearerToken = await getToken();

    final res = await http.get(Uri.parse("$baseUrl/doctor/queue"),
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
      print("there is some error in MY prescriptions ${res.body}");
      return [];
    }
  }catch(e){
    print("Error get MY /doctor/queue : " + e.toString());
    return [];
  }
}
