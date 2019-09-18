import 'dart:async';
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
    print ('db: $path');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE car(id INTEGER PRIMARY KEY, userId INTEGER, tipo TEXT, nome TEXT, descricao TEXT, urlFoto TEXT, urlVideo TEXT, latitude TEXT, longitude TEXT)');
  }

  Future<FutureOr<void>> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print ('_onUpgrade: oldVersion $oldVersion > newVersion: $newVersion');

    if (oldVersion == 1 && newVersion == 2) {
      await db.execute('alter table car add column userId INTEGER');
    }
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}