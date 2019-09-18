import 'package:carros/api/cars_api.dart';
import 'package:carros/database/car_dao.dart';
import 'package:carros/models/car.dart';
import 'package:carros/pages/detail/car_page.dart';
import 'package:carros/widgets/card_car.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

import 'cars_bloc.dart';

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

  CarsListView.favorites() {
    _type = CarDao.FAVORITES;
  }

  @override
  _CarsListViewState createState() => _CarsListViewState();

}

class _CarsListViewState extends State<CarsListView> with AutomaticKeepAliveClientMixin<CarsListView>{
  CarsBloc _bloc = CarsBloc();

  @override
  void initState() {

    _bloc.loadCars(widget._type);

    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget._type == CarDao.FAVORITES) {
      _bloc.loadCars(widget._type);
    }

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError(snapshot.error);
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: _getCardList(snapshot.data),
        );

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
              onPressed: () => _bloc.onClickDetails(context, CarPage(carros[index]),),
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

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }


  Future<List<Car>> _onRefresh() {
    return _bloc.loadCars(widget._type);
  }

}
