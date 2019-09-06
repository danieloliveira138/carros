import 'package:carros/models/user.dart';
import 'package:carros/widgets/cars_listview.dart';
import 'package:carros/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  User user;

  Home(this.user);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin<Home>{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Carros'),
          bottom: TabBar(tabs: _getTabs()),
        ),
        body: _body(),
        drawer: MenuList(),
      ),
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
