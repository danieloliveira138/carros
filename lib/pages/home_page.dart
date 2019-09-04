import 'package:carros/models/user.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  User user;


  Home(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  _appbar() {
    return AppBar(
      title: Text('Carros'),
    );
  }

  _body() {
    return Center(
      child: Text(
        '''
        Nome: ${user?.nome}
        email: ${user?.email}
        ''',
      ),
    );
  }
}
