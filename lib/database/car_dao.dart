import 'package:carros/database/base_dao.dart';
import 'package:carros/models/car.dart';

class CarDao extends BaseDao<Car> {

  @override
  String get tableName => "car";

  @override
  Car fromJson(Map<String, dynamic> json) => Car.fromJson(json);

}