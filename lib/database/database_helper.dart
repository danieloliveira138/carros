import 'dart:async';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final DatabaseHelper _instance = DatabaseHelper.getInstance();

  DatabaseHelper.getInstance();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await _initDb();

    return _db;
  }

  Future _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'cars.db');
    print ('init database');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    String createTableCar = await rootBundle.loadString("assets/sql/create_table_car.sql");
    String createTableFavorite = await rootBundle.loadString("assets/sql/create_table_favorite.sql");

    await db.execute(createTableCar);
    await db.execute(createTableFavorite);
  }

  Future<FutureOr<void>> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print ('_onUpgrade: oldVersion $oldVersion > newVersion: $newVersion');

    if (oldVersion == 1 && newVersion == 2) {
      // Do when upgrade
    }
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}