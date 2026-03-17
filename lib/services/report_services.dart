import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/jwt_services.dart';
import '../utils/local_data.dart';
import 'auth_api.dart';


Future<Map<String, dynamic>> getReportById({required int appId}) async{
  try{
    final bearerToken = await getToken();

    final res = await http.get(Uri.parse("$baseUrl/reports/$appId"),
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
      print("there is some error in report/id ${res.body}");
      return json.decode(res.body);
    }
  }catch(e){
    print("Error get /report/id : " + e.toString());
    return {};
  }
}

Future<List<dynamic>> getMyReport() async{
  try{
    final bearerToken = await getToken();

    final res = await http.get(Uri.parse("$baseUrl/reports/my"),
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
      print("there is some error in MY reports ${res.body}");
      return [];
    }
  }catch(e){
    print("Error get MY /reports/id : " + e.toString());
    return [];
  }
}

