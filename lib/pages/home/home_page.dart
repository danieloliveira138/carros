import 'package:carros/utils/shared_preferences.dart';
import 'package:carros/pages/home/cars_listview.dart';
import 'package:carros/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

import 'home_bloc.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin<Home> {
  TabController _tabController;

  HomeBloc _bloc = HomeBloc();

  static const String TAB_INDEX = 'tab_index';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _bloc.stream,
      initialData: -1,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: _appBar(snapshot.data),
          body: _body(snapshot.data),
          drawer: MenuList(
            favorite: () => _bloc.favoriteScaffold(),
            home: () => _bloc.homeScaffold(),
          ),
        );
      },
    );
  }

  _appBar(int opt) {
    switch (opt) {
      case 1:
        return AppBar(
          title: Text('Favoritos'),
        );
        break;

      case -1:
        _initTabs();
        return AppBar(
          title: Text('Carros'),
          bottom: TabBar(
            tabs: _getTabs(),
            controller: _tabController,
          ),
        );
        break;
    }
  }

  _body(int opt) {
    switch (opt) {
      case 1:
        return CarsListView.favorites();
        break;

      case -1:
        return TabBarView(
          controller: _tabController,
          children: <Widget>[
            CarsListView.classics(),
            CarsListView.sportive(),
            CarsListView.lux(),
          ],
        );
        break;
    }
  }

  _getTabs() {
    return [
      Tab(
        text: "Clássicos",
      ),
      Tab(
        text: "Esportivos",
      ),
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

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
