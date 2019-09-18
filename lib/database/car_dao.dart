import 'package:carros/database/database_helper.dart';
import 'package:carros/models/car.dart';
import 'package:sqflite/sqflite.dart';

class CarDao {

  Future<Database> get db => DatabaseHelper.getInstance().db;

  static const FAVORITES = 'Favoritos';

  Future<int> save(Car car) async {
    var dbClient = await db;
    var id = await dbClient.insert('car', car.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print ('db saved car id: $id');
    return id;
  }

  Future<List<Car>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('SELECT * FROM car');

    return _getCarList(list);
  }

  Future<List<Car>> findAllByType(String tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('SELECT * FROM car WHERE tipo =? ', [tipo]);

    return _getCarList(list);
  }

  Future<Car> findById(int id) async {
    final dbClient = await db;

    final map = await dbClient.rawQuery('SELECT * FROM car WHERE id =? ', [id]);

    if (map.length == 1) {
      return Car.fromJson(map.first);
    }

    return null;

  }

  Future<bool> exists(Car car) async {
    Car carRecord = await findById(car.id);
    return carRecord != null;
  }

  Future<int> count() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('SELECT COUNT(*) FROM car');

    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    final dbClient = await db;

    return await dbClient.rawDelete('DELETE FROM car where id =? ', [id]);
  }

  Future<int> deleteAll() async {
    final dbClient = await db;

    return await dbClient.rawDelete('DELETE FROM car');
  }

  List<Car> _getCarList(List<Map<String, dynamic>> list) {
    return list.map<Car>((json) => Car.fromJson(json)).toList();
  }
}