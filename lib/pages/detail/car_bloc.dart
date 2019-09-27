import 'dart:async';
import 'package:carros/api/lorem_api.dart';
import 'package:carros/database/car_dao.dart';
import 'package:carros/database/favorite_dao.dart';
import 'package:carros/models/car.dart';
import 'package:carros/models/favorite.dart';
import 'package:carros/models/user.dart';

class CarBloc{
  
  static const String EDIT = 'edit';
  static const String DELETE = 'delete';
  static const String SHARE = 'share';

  CarDao _carDao = CarDao();
  FavoriteDao _favoriteDao = FavoriteDao();

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
    User user = await User.loadUser();
    Favorite favorite = Favorite(id: car.id, userId: user.id);

    final isFavorite = await _favoriteDao.isFavorite(favorite);

    if (isFavorite) {

      await _favoriteDao.unFavorite(favorite);
      print('Set unfavorite');
    } else {
      print('Set unfavorite');
      await _favoriteDao.save(favorite);
    }

    _streamFavorite.add(!isFavorite);

  }

  isCarFavorite(Car car) async {
    User user = await User.loadUser();
    Favorite favorite = Favorite(id: car.id, userId: user.id);

    var isFavorite = await _favoriteDao.isFavorite(favorite);
    print('isCarFavorite -> $isFavorite');
    _streamFavorite.add(isFavorite);
  }

  void onClickShare() {
  }

  void dispose() {
    _streamController.close();
    _streamFavorite.close();
  }
}