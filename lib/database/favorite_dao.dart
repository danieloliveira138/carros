import 'package:carros/database/base_dao.dart';
import 'package:carros/models/favorite.dart';

class FavoriteDao extends BaseDao<Favorite> {

  // ignore: non_constant_identifier_names
  static const String FAVORITES = 'Favoritos';

  @override
  Favorite fromJson(Map<String, dynamic> json) => Favorite.fromJson(json);

  @override
  String get tableName => 'favorite';

  Future<bool> isFavorite(Favorite favorite) async {
    final dbClient = await db;
    final map = await dbClient.rawQuery('SELECT * FROM $tableName WHERE id =? AND '
        'userId =? ', [favorite.id, favorite.userId]);
    return map.length >= 1;
  }


  Future<int> unFavorite(Favorite favorite) async {
    final dbClient = await db;

    return await dbClient.rawDelete('DELETE FROM $tableName WHERE id =? AND '
        'userId =? ', [favorite.id, favorite.userId]);
  }

}