import 'package:carros/models/user.dart';
import 'package:carros/widgets/cars_listview.dart';
import 'package:carros/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  User user;

  Home(this.user);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _appbar(),
        body: _body(),
        drawer: MenuList(),
      ),
    );
  }

  _appbar() {
    return AppBar(
      title: Text('Carros'),
      bottom: TabBar(tabs: _getTabs()),
    );
  }

  _body() {
    return TabBarView(
      children: <Widget>[
        CarsListView.classics(),
        CarsListView.sportive(),
        CarsListView.lux(),
      ],
    );
  }

  _getTabs() {
    return [
      Tab(text: "Clássicos",),
      Tab(text: "Esportivos",),
      Tab(text: "Luxo"),
    ];
  }

}
