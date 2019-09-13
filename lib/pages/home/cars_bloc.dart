import 'dart:async';

import 'package:carros/api/cars_api.dart';
import 'package:carros/models/car.dart';
import 'package:carros/pages/car_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class CarsBloc {

  final _streamController = StreamController<List<Car>>();

  get stream => _streamController.stream;

  dispose() {
    _streamController.close();
  }

  void loadCars(String type) async {

    var cars = await CarsApi.getListCars(type: type);

    _streamController.add(cars);
  }


  void onClickDetails(BuildContext context, CarPage page){
    nav(context, page);
  }

}