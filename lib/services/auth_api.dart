import "dart:convert";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart" as http;
import "../utils/jwt_services.dart";
import "../utils/local_data.dart";


final baseUrl = dotenv.env["BASE_URL"];

Future<Map<String, dynamic>> loginUser({required String email,required  String password}) async{
  try{
    final res = await http.post(Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-type": "application/json", "Accept": "application/json"},
        body: json.encode({
          "email":email,
          "password":password
        })
    );

    if(res.statusCode == 200){
      print("Authorised");

      final data = json.decode(res.body);

        await setToken(data["token"]);
        print(await getJwtTokenData());

        return data;
    }

    if(res.statusCode == 400){
      throw Exception("Authentication failed in user login");
    }

    return json.decode(res.body);
  }catch(e){
    print("Error in /user/auth/login : " + e.toString());
    return {};
  }
}