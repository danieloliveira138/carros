import 'package:carros/api/login_api.dart';
import 'package:carros/pages/home_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = TextEditingController();

  final _passwdController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  final _focusPasswd = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  _appbar() {
    return AppBar(
      title: Text(
        'Carros',
      ),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppTextField('Login', 'Digite seu login',
            controller: _loginController,
            validator: _validateLogin,
            textInputAction: TextInputAction.next,
            nextFocus: _focusPasswd),
            SizedBox(
              height: 16,
            ),
            AppTextField('Senha', 'Digite sua senha',
              obscure: true,
              controller: _passwdController,
              validator: _validatePasswd,
              keyboardType: TextInputType.number,
              focusNode: _focusPasswd),
            SizedBox(
              height: 24,
            ),
            AppButton('Login', _onClickLogin),
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    bool formOk = _formKey.currentState.validate();
    if (!formOk) {
      return;
    }

    String login = _loginController.text;
    String passwd = _passwdController.text;
    print(
        'Login: ${_loginController.text}\nPassword: ${_passwdController.text}');

    bool validator = await LoginApi.login(login, passwd);

    if(validator) {
      nav(context, Home(_loginController.text));
    }

  }

  String _validateLogin(String value) {
    if (value.isEmpty) {
      return 'Digite seu login';
    }
    return null;
  }

  String _validatePasswd(String value) {
    if (value.isEmpty) {
      return 'Digite sua senha';
    }
    if (value.length <= 3) {
      return 'A senha precisa ter no mínimo 4 letras ou números';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
