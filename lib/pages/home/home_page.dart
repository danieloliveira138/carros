import 'package:carros/utils/shared_preferences.dart';
import 'package:carros/pages/home/cars_listview.dart';
import 'package:carros/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin<Home>{

  TabController _tabController;

  static const String TAB_INDEX = 'tab_index';

  @override
  void initState() {
    super.initState();

    _initTabs();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
        bottom: TabBar(
          tabs: _getTabs(),
          controller: _tabController,
        ),
      ),
      body: _body(),
      drawer: MenuList(),
    );
  }

  _body() {
    return TabBarView(
      controller: _tabController,
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

  _initTabs() async {

    _tabController = TabController(length: 3, vsync: this);

    _tabController.index = await SharedPrefs.getPrefInt(TAB_INDEX) ?? 0;

    _tabController.addListener(() {

      print("Tab: ${_tabController.index}");

      SharedPrefs.setPrefInt(TAB_INDEX, _tabController.index);

    });

  }

}