import 'package:carros/database/database_helper.dart';
import 'package:carros/models/entity.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDao<T extends Entity> {

  String get tableName;

  Future<Database> get db => DatabaseHelper.getInstance().db;

  T fromJson(Map<String, dynamic> json);

  Future<int> save(T entity) async {
    var dbClient = await db;
    var id = await dbClient.insert(tableName, entity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print ('db saved car id: $id');
    return id;
  }

  Future<bool> saveAll(List<T> entity) async {
    entity.forEach((entity) {
      print(entity);
      save(entity);
    });

    return await count() == entity.length;
  }

  Future<List<T>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('SELECT * FROM $tableName');

    return getTList(list);
  }

//  Future<List<T>> findAllByUser(int userId) async {
//    final dbClient = await db;
//
//    final list = await dbClient.rawQuery('SELECT * FROM car WHERE userId =?', [userId]);
//
//    return getTList(list);
//  }

  Future<List<T>> findAllByType(String tipo) async {
    final dbClient = await db;

    return getTList(await dbClient.rawQuery('SELECT * FROM $tableName WHERE tipo =? ', [tipo]));

  }

  Future<T> findById(int id) async {
    final dbClient = await db;

    final map = await dbClient.rawQuery('SELECT * FROM $tableName WHERE id =? ', [id]);

    if (map.length == 1) {
      return fromJson(map.first);
    }

    return null;

  }

//  Future<T> findByIdAndUser(int id, int userId) async {
//    final dbClient = await db;
//
//    final map = await dbClient.rawQuery('SELECT * FROM $tableName WHERE id =? AND userId=? ', [id, userId]);
//
//    if (map.length == 1) {
//      print('T Saved = $map');
//      return fromJson(map.first);
//    }
//
//    return null;
//
//  }

  Future<bool> exists(int id) async => await findById(id) != null;

  Future<int> count() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('SELECT COUNT(*) FROM $tableName');

    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    final dbClient = await db;

    return await dbClient.rawDelete('DELETE FROM $tableName where id =? ', [id]);
  }

  Future<int> deleteAll() async {
    final dbClient = await db;

    return await dbClient.rawDelete('DELETE FROM $tableName');
  }

  List<T> getTList(List<Map<String, dynamic>> list) {
    return list.map<T>((json) => fromJson(json)).toList();
  }
}