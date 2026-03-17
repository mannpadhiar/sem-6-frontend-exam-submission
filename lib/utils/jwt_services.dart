import 'package:jwt_decoder/jwt_decoder.dart';

import 'local_data.dart';

Future<dynamic> getJwtTokenData() async{
  String token = await getToken();

  dynamic tokenData = JwtDecoder.decode(token);

  return JwtDecoder.isExpired(token)? null : tokenData;
}