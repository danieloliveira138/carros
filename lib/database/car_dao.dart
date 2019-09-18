import 'package:carros/database/database_helper.dart';
import 'package:carros/models/car.dart';
import 'package:sqflite/sqflite.dart';

class CarDao {

  static const String FAVORITES = 'Favoritos';

  Future<Database> get db => DatabaseHelper.getInstance().db;

  Future<int> save(Car car) async {
    var dbClient = await db;
    var id = await dbClient.insert('car', car.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print ('db saved car id: $id');
    return id;
  }

  Future<int> saveFavorite(Car car, int userId) async {
    car.userId = userId;
    var dbClient = await db;
    var id = await dbClient.insert('car', car.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print ('db saved car id: $id');
    return id;
  }

  Future<List<Car>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('SELECT * FROM car');

    return getCarList(list);
  }

  Future<List<Car>> findAllByUser(int userId) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('SELECT * FROM car WHERE userId =?', [userId]);

    return getCarList(list);
  }

  Future<List<Car>> findAllByType(String tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('SELECT * FROM car WHERE tipo =? ', [tipo]);

    return getCarList(list);
  }

  Future<Car> findById(int id) async {
    final dbClient = await db;

    final map = await dbClient.rawQuery('SELECT * FROM car WHERE id =? ', [id]);

    if (map.length == 1) {
      return Car.fromJson(map.first);
    }

    return null;

  }

  Future<Car> findByIdAndUser(int id, int userId) async {
    final dbClient = await db;

    final map = await dbClient.rawQuery('SELECT * FROM car WHERE id =? AND userId=? ', [id, userId]);

    if (map.length == 1) {
      print('Car Saved = $map');
      return Car.fromJson(map.first);
    }

    return null;

  }

  Future<bool> exists(Car car) async {
    Car carRecord = await findById(car.id);
    return carRecord != null;
  }

  Future<bool> existsByUser(Car car, int userId) async {
    Car carRecord = await findByIdAndUser(car.id, userId);
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

  Future<int> deleteByUser(int id, int userId) async {
    final dbClient = await db;

    return await dbClient.rawDelete('DELETE FROM car where id =? AND userId =?', [id, userId]);
  }

  Future<int> deleteAll() async {
    final dbClient = await db;

    return await dbClient.rawDelete('DELETE FROM car');
  }

  List<Car> getCarList(List<Map<String, dynamic>> list) {
    return list.map<Car>((json) => Car.fromJson(json)).toList();
  }
}