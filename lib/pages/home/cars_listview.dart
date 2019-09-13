import 'package:carros/api/cars_api.dart';
import 'package:carros/models/car.dart';
import 'package:carros/pages/car_page.dart';
import 'package:carros/widgets/card_car.dart';
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

    return StreamBuilder(
      stream: _bloc.stream,
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

}
