import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  String _userName;


  Home(this._userName);

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
        _userName,
      ),
    );
  }
}
