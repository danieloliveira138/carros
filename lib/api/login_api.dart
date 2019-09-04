import 'dart:convert';
import 'package:carros/models/api_response.dart';
import 'package:carros/models/user.dart';
import 'package:http/http.dart' as http;

class LoginApi {

  static Future<ApiResponse<User>> login(String login, String senha) async {
    var url = 'https://carros-springboot.herokuapp.com/api/v2/login';

    Map<String, String> headers = {
      "Content-Type": "application/json"
    };

    Map params = {
      "username": login,
      "password": senha
    };

    String body = json.encode(params);

    var response = await http.post(url, body: body, headers: headers);

    Map mapResponse = json.decode(response.body);

    if(response.statusCode == 200) {

      final user = User.fromJson(mapResponse);

      print(user.toString());

      return ApiResponse.success(user);

    }

      return ApiResponse.error(mapResponse['error']);

  }

}