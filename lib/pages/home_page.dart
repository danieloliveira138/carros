import 'package:carros/api/cars_api.dart';
import 'package:carros/models/car.dart';
import 'package:carros/models/user.dart';
import 'package:carros/widgets/card_car.dart';
import 'package:carros/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  User user;

  Home(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
      drawer: MenuList(),
    );
  }

  _appbar() {
    return AppBar(
      title: Text('Carros'),
    );
  }

  _body() {
    List<Car> carros = CarsApi.mockListCar();

    return ListView.builder(
      itemCount: carros.length,
      itemBuilder: (BuildContext context, int index) {
        return CardCar(
          carros[index],
          index,
          carros.length,
          actions: <Widget>[
            FlatButton(
              child: Text('Descrição'),
              onPressed: () { },
            ),
            FlatButton(
              child: Text('Compartilhar'),
              onPressed: () { },
            ),
          ],
        );
      },
    );
  }
}
