import 'dart:async';
import 'package:carros/api/login_api.dart';
import 'package:carros/models/api_response.dart';
import 'package:carros/models/user.dart';
import 'package:carros/pages/home_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

class LoginBlock {

  final _streamController = StreamController<bool>();

  ApiResponse response;

  var error;

  get stream => _streamController.stream;

  Future<ApiResponse<User>> login(String login, String password) async {
    _streamController.add(true);
    try {
      response = await LoginApi.login(login, password);
    } catch (error) {
      response.msg = error;
    }
    if (!response.status)
      _streamController.addError(response.msg);

    return response;
  }

  dispose() {
    _streamController.close();
  }

  load(BuildContext context, Widget page, bool replace) async {
    User user = await User.loadUser();
    if (user != null) {
      nav(context, page, replace: replace);
    }
  }

  String validateLogin(String value) {
    if (value.isEmpty) {
      return 'Digite seu login';
    }
    return null;
  }

  String validatePasswd(String value) {
    if (value.isEmpty) {
      return 'Digite sua senha';
    }
    if (value.length <= 2) {
      return 'A senha precisa ter no mínimo 3 letras ou números';
    }
    return null;
  }

  onClickLogin(context, formKey, loginController, passwdController) async {

    bool formOk = formKey.currentState.validate();
    if (!formOk) {
      return;
    }

    String login = loginController.text;
    String passwd = passwdController.text;
    ApiResponse response = await this.login(login, passwd);

    if(response.status) {
      nav(context, Home(), replace: true);
    } else {
      alertDialog(context, "Erro", response.msg, ok: () => pop(context));
    }
  }

}