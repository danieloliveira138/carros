import 'dart:async';

import 'package:carros/api/login_api.dart';
import 'package:carros/models/api_response.dart';
import 'package:carros/models/user.dart';

class LoginBlock {

  final _streamController = StreamController<bool>();

  get stream => _streamController.stream;

  Future<ApiResponse<User>> login(String login, String password) async {
    _streamController.add(true);

    ApiResponse response = await LoginApi.login(login, password);

    _streamController.add(false);

    return response;
  }


  dispose() {
    _streamController.close();
  }
}