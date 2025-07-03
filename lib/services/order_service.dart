
import 'package:mad_2_412/data/sqflite_db_data.dart';
import 'package:mad_2_412/model/order.dart';

class OrderService {

  static final OrderService instance = OrderService._();

  OrderService._();

  Future<void> insertOrder(Order order) async {
      final db =  await SqfliteDbData.instance.database;
      await db.insert(DBConstant.orderTable, order.toMap());
  }

  Future<List<Order>> getOrders() async {
    final db =  await SqfliteDbData.instance.database;
    final List<Map<String, dynamic>> results = await db.query(DBConstant.orderTable);
    List<Order> orders = results.map((e) => Order.fromMap(e)).toList();
    return orders;
  }

  Future<void> deleteOrder(int id) async {
    final db =  await SqfliteDbData.instance.database;
    await db.delete(DBConstant.orderTable, where: 'id = ?', whereArgs: [id]);
  }
}