import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/jwt_services.dart';
import '../utils/local_data.dart';
import 'auth_api.dart';


Future<Map<String, dynamic>> getPrescriptionById(int id) async{
  try{
    final bearerToken = await getToken();

    final res = await http.get(Uri.parse("$baseUrl/prescriptions/$id"),
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
      print("there is some error in prescriptions/id ${res.body}");
      return json.decode(res.body);
    }
  }catch(e){
    print("Error get /prescriptions/id : " + e.toString());
    return {};
  }
}

Future<List<dynamic>> getMyPrescription() async{
  try{
    final bearerToken = await getToken();

    final res = await http.get(Uri.parse("$baseUrl/prescriptions/my"),
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
    print("Error get MY /prescriptions/id : " + e.toString());
    return [];
  }
}

