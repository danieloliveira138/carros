import 'dart:async';
import 'package:carros/api/cars_api.dart';
import 'package:carros/models/car.dart';
import 'package:carros/pages/car_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class CarsBloc {

  final _streamController = StreamController<List<Car>>();

  get stream => _streamController.stream;

  void loadCars(String type) async {

    try {

      List<Car> cars = await CarsApi.getListCars(type: type);

      _streamController.add(cars);

    } catch (error, exception) {

      print('Car list error: $exception');

      _streamController.addError('Erro ao acessar o servidor de dados.');

    }

  }


  void onClickDetails(BuildContext context, CarPage page){
    nav(context, page);
  }

  dispose() {
    _streamController.close();
  }

}