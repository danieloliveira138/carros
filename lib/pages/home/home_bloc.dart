import 'dart:async';

class HomeBloc {
  final StreamController _streamController = StreamController<int>();

  get stream => _streamController.stream;

  favoriteScaffold() => _streamController.add(1);

  homeScaffold() => _streamController.add(-1);

  dispose() {
    _streamController.close();
  }
}