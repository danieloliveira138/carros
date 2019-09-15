import 'dart:async';

import 'package:carros/api/lorem_api.dart';
import 'package:carros/models/api_response.dart';

class CarBloc{
  
  static const String EDIT = 'edit';
  static const String DELETE = 'delete';
  static const String SHARE = 'share';

  StreamController _streamController = StreamController<String>();

  Stream<String> get stream => _streamController.stream;

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

  void onClickFavorite() {
  }

  void onClickShare() {
  }

  void dispose() {
    _streamController.close();
  }
}