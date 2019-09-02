import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _loginController = TextEditingController();
  final _passwdController = TextEditingController();

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
    return Container(
      margin: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          _textFormField('Login', 'Digite seu login', controller: _loginController),
          SizedBox(height: 16,),
          _textFormField('Senha', 'Digite sua senha', obscure: true, controller: _passwdController),
          SizedBox(height: 24,),
          _loginButton('Login', _onClickLogin),
        ],
      ),
    );
  }

  _loginButton(title, onPressed) {
    return Container(
          height: 46,
          child: RaisedButton(
            color: Colors.blueAccent,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            onPressed: onPressed,
          ),
        );
  }

  _textFormField(labelText, hintText, {obscure = false, controller}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(
        fontSize: 22,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 22
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 22
        )
      ),
    );
  }

  _onClickLogin() {
    print('Login: ${_loginController.text}\nPassword: ${_passwdController.text}');
  }


}
