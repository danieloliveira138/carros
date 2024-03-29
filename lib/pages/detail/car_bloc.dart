import 'dart:async';

import 'package:carros/api/lorem_api.dart';
import 'package:carros/database/car_dao.dart';
import 'package:carros/models/car.dart';

class CarBloc{
  
  static const String EDIT = 'edit';
  static const String DELETE = 'delete';
  static const String SHARE = 'share';

  CarDao _carDao = CarDao();

  StreamController _streamController = StreamController<String>();

  StreamController _streamFavorite = StreamController<bool>();

  Stream<String> get stream => _streamController.stream;

  Stream<bool> get favorite => _streamFavorite.stream;

  loadLoremIpsum() async {
    var response = await LoremIpsumApi.getLoremIpsum();

    print('reponse: ${response.result}');
    print('reponse status: ${response.status}');

    if (response.status){
      _streamController.add(response.result);
    } else {
      _streamController.addError(response.msg);
    }

  }

  void onClickMap() {

  }

  void onClickPopupMenu(String value) {
    switch (value) {
      case EDIT:
        print(value);
        break;
      case SHARE:
        print(value);
        break;
      case DELETE:
        print(value);
        break;

    }
  }

  void onClickVideo() {
  }

  void onClickFavorite(Car car) async {
    var carSavedOnDB = await _carDao.exists(car);

    if (carSavedOnDB) {
      await _carDao.delete(car.id);
    } else {
      await _carDao.save(car);
    }

    _streamFavorite.add(!carSavedOnDB);

  }

  isCarFavorite(Car car) async {
    var isCarSavedOnBD = await _carDao.exists(car);
    _streamFavorite.add(isCarSavedOnBD);
  }

  void onClickShare() {
  }

  void dispose() {
    _streamController.close();
    _streamFavorite.close();
  }
}