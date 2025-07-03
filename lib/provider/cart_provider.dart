

import 'package:flutter/material.dart';
import 'package:mad_2_412/model/order.dart';
import 'package:mad_2_412/services/order_service.dart';

class CartProvider with ChangeNotifier {

  Future<void> addToCart(Order order) async {
    final orderService = OrderService.instance;
    await orderService.insertOrder(order);
    notifyListeners();
  }

  Future<void> removeFromCart(int id) async {
    final orderService = OrderService.instance;
    await orderService.deleteOrder(id);
    notifyListeners();
  }

  Future<List<Order>> getOrders() async {
    final orderService = OrderService.instance;
    return await orderService.getOrders();
  }

}