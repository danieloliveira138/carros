import 'package:carros/models/car.dart';
import 'package:flutter/material.dart';

class CarPage extends StatelessWidget {
  Car _car;

  CarPage(this._car);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(_car.nome),
      body: _body(_car),
    );
  }

  _body(Car car) {
    return Center(
      child: Image.network(
        _car.urlFoto,
      ),
    );
  }

  _appBar(String title) {
    return AppBar(
      title: Text(title),
    );
  }
}
