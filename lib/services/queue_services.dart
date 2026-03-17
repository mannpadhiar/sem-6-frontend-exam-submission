import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/local_data.dart';
import 'auth_api.dart';

Future<List<dynamic>> getQueue(String date) async{
  try{
    final bearerToken = await getToken();

    final res = await http.get(Uri.parse("$baseUrl/queue?date=$date"),
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
      print("there is some error in MY queue ${res.body}");
      return [];
    }
  }catch(e){
    print("Error get MY /queue : " + e.toString());
    return [];
  }
}

Future<List<dynamic>> setQueueType(int id,String process) async{
  try{
    final bearerToken = await getToken();

    final res = await http.patch(Uri.parse("$baseUrl/appointments/$id}"),
      headers: {
        'Content-Type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization' : "Bearer $bearerToken"
      },
      body: {
        "status": process,
      }
    );

    if(res.statusCode == 200 || res.statusCode == 201){
      return json.decode(res.body);
    }
    else{
      print("there is some error in MY queue update ${res.body}");
      return [];
    }
  }catch(e){
    print("Error patch queue/id : " + e.toString());
    return [];
  }
}
