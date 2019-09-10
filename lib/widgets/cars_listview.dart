import 'dart:async';

import 'package:carros/api/cars_api.dart';
import 'package:carros/models/car.dart';
import 'package:carros/pages/car_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/card_car.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CarsListView extends StatefulWidget {

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
  _CarsListViewState createState() => _CarsListViewState();

}

class _CarsListViewState extends State<CarsListView> with AutomaticKeepAliveClientMixin<CarsListView>{

  final _streamController = StreamController<List<Car>>();

  @override
  void initState() {

    _loadCars();

    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erro ao Acessar o Servidor',
              style: TextStyle(
                fontSize: 22,
                color: Colors.red
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return _getCardList(snapshot.data);

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
              onPressed: () => _onClickDetails(carros[index]),
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

  _onClickDetails(Car car){
    nav(context, CarPage(car));
  }

  void _loadCars() async {

    var cars = await CarsApi.getListCars(type: widget._type);

    _streamController.add(cars);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

}
