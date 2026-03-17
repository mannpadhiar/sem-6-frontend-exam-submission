import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/jwt_services.dart';
import '../utils/local_data.dart';
import 'auth_api.dart';

Future<Map<String, dynamic>> addAppointment(Map<String,dynamic> user) async{
  try{
    final bearerToken = await getToken();

    final res = await http.post(Uri.parse("$baseUrl/appointments"),
      headers: {
        'Content-Type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization' : "Bearer $bearerToken"
      },
      body: json.encode(user),
    );

    if(res.statusCode == 201){
      print("appointment added ${res.body}");
      return json.decode(res.body);
    }
    else{
      print("there is some error in appointments ${res.body}");
      return json.decode(res.body);
    }
  }catch(e){
    print("Error POST /appointments : " + e.toString());
    return {};
  }
}

Future<Map<String, dynamic>> getAppointmentById(int id) async{
  try{
    final bearerToken = await getToken();

    final res = await http.get(Uri.parse("$baseUrl/appointments/$id"),
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
      print("there is some error in appointments/id ${res.body}");
      return json.decode(res.body);
    }
  }catch(e){
    print("Error get /appointments/id : " + e.toString());
    return {};
  }
}

Future<List<dynamic>> getMyAppointments() async{
  try{
    final bearerToken = await getToken();

    final res = await http.get(Uri.parse("$baseUrl/appointments/my}"),
      headers: {
        'Content-Type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization' : "Bearer $bearerToken"
      },
    );

    if(res.statusCode == 200 || res.statusCode == 201){
      return json.decode(res.body);
    }
    else{
      print("there is some error in MY appointments ${res.body}");
      return [];
    }
  }catch(e){
    print("Error get MY /appointments/id : " + e.toString());
    return [];
  }
}



