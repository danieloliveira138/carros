import 'package:carros/api/cars_api.dart';
import 'package:carros/models/car.dart';
import 'package:carros/widgets/card_car.dart';
import 'package:flutter/material.dart';

class CarsListView extends StatelessWidget {

  String _type;

  CarsListView();

  CarsListView.classics() {
    _type = CarsApi.CLASSICOS;
  }

  CarsListView.lux() {
    _type = CarsApi.LUXO;
  }

  CarsListView.sportive() {
    _type = CarsApi.ESPORTIVOS;
  }

  @override
  Widget build(BuildContext context) {

    Future<List<Car>> future = CarsApi.getListCars(type: _type);

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(
          child: CircularProgressIndicator(),
        )
            : _getCardList(snapshot.data);
      },
    );
  }

  _getCardList(data) {

    List<Car> carros = data;

    return ListView.builder(
      itemCount: carros != null ? carros.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return CardCar(
          carros[index],
          index,
          carros.length,
          actions: <Widget>[
            FlatButton(
              child: Text('Descrição'),
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Compartilhar'),
              onPressed: () {},
            ),
          ],
        );
      },
    );

  }

}