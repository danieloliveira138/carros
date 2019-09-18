import 'dart:async';
import 'package:carros/api/cars_api.dart';
import 'package:carros/database/car_dao.dart';
import 'package:carros/models/car.dart';
import 'package:carros/pages/detail/car_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class CarsBloc {

  final _carDao = CarDao();

  final _streamController = StreamController<List<Car>>();

  get stream => _streamController.stream;

  Future<List<Car>> loadCars(String type) async {
    List<Car> cars;

    if (type == CarDao.FAVORITES) {
      cars = await _carDao.findAll();
      _streamController.add(cars);

      return cars ?? <Car> [];
    }

    try {

       cars = await CarsApi.getListCars(type: type);

      _streamController.add(cars);

    } catch (error, exception) {

      print('Car list error: $exception');

      _streamController.addError('Erro ao acessar o servidor de dados.');

    }

    return cars;

  }


  void onClickDetails(BuildContext context, CarPage page){
    nav(context, page);
  }

  dispose() {
    _streamController.close();
  }

}