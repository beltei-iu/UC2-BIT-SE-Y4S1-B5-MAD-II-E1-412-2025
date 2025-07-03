
import 'package:get/get.dart';
import 'package:mad_2_412/model/order.dart';
import 'package:mad_2_412/services/order_service.dart';

class CartController extends GetxController {

  var cartTotal = 0.obs;

  Future<void> addToCart(Order order) async {
    final orderService = OrderService.instance;
    await orderService.insertOrder(order);
    getOrders();
  }

  Future<void> removeFromCart(int id) async {
    final orderService = OrderService.instance;
    await orderService.deleteOrder(id);
    getOrders();
  }

  Future<List<Order>> getOrders() async {
    final orderService = OrderService.instance;
    List<Order> orders = await orderService.getOrders();
    cartTotal.value = orders.length;
    return orders;
  }
}