
import 'package:mad_2_412/data/sqflite_db_data.dart';
import 'package:mad_2_412/model/favorite.dart';

class FavoriteService {

  static final FavoriteService instance = FavoriteService._();

  FavoriteService._();

  Future<void> insertOrder(Favorite favorite) async {
    final db =  await SqfliteDbData.instance.database;
    await db.insert(DBConstant.favoriteTable, favorite.toMap());
  }

  Future<List<Favorite>> getOrders() async {
    final db =  await SqfliteDbData.instance.database;
    final List<Map<String, dynamic>> results = await db.query(DBConstant.favoriteTable);
    List<Favorite> favorites = results.map((e) => Favorite.fromMap(e)).toList();
    return favorites;
  }

  Future<void> deleteOrder(int id) async {
    final db =  await SqfliteDbData.instance.database;
    await db.delete(DBConstant.favoriteTable, where: 'id = ?', whereArgs: [id]);
  }
}