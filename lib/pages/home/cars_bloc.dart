import 'dart:async';
import 'package:carros/api/cars_api.dart';
import 'package:carros/database/car_dao.dart';
import 'package:carros/database/favorite_dao.dart';
import 'package:carros/models/car.dart';
import 'package:carros/models/user.dart';
import 'package:carros/pages/detail/car_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class CarsBloc {

  final _carDao = CarDao();
  final _favoriteDao = FavoriteDao();

  final _streamController = StreamController<List<Car>>();

  get stream => _streamController.stream;

  Future<List<Car>> loadCars(String type) async {

    switch (type) {
      case FavoriteDao.FAVORITES:
        return _loadFavoriteCars();
      default:
        return _loadCarsFromApi(type);
    }

  }


  void onClickDetails(BuildContext context, CarPage page){
    nav(context, page);
  }

  dispose() {
    _streamController.close();
  }

  Future<List<Car>> _loadFavoriteCars() async {
    User user = await User.loadUser();


//    List<Car> cars = await _carDao.findAllByUser(user.id);
//
//    if (cars == null){
//      _streamController.addError('Nenhum Carro Salvo');
//    } else {
//      _streamController.add(cars);
//    }

    return /*cars ??*/ <Car> [];
  }

  Future<List<Car>> _loadCarsFromApi(type) async {
    List<Car> cars;
    try {

      cars = await CarsApi.getListCars(type: type);

      _carDao.saveAll(cars);

      _streamController.add(cars);

    } catch (error, exception) {

      print('Car list error: $exception');

      _streamController.addError('Erro ao acessar o servidor de dados.');

    }

    return cars;
  }

}