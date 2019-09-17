import 'package:carros/models/car.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardCar extends StatelessWidget {
  Car car;
  int index;
  int carsSize;
  bool favorite;
  List<Widget> actions = [];

  CardCar(this.car, this.index, this.carsSize, {this.actions, this.favorite = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 8, left: 8, right: 8, bottom: _lastChildMargin(carsSize, index)),
      child: Container(
        child: Card(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        car.urlFoto ?? "Image not find",
                        width: 200,
                      ),
                      Container(
                        child: Icon(
                          Icons.favorite,
                          color: favorite ? Colors.red : Colors.white,
                        )


                      ),
                    ],
                  )
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    car.nome,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    'Categoria: ${car.tipo}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    children: actions,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _lastChildMargin(int length, int index) {
    return (length == (index + 1)) ? 8 : 0;
  }
}
