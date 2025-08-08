import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_412/controller/cart_controller.dart';
import 'package:mad_2_412/data/file_storage_data.dart';
import 'package:mad_2_412/model/order.dart';
import 'package:mad_2_412/services/order_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Order> _orders = [];
  final cartController = CartController();

  @override
  void initState() {
    super.initState();
    loadOrder();
  }

  Future<void> loadOrder() async {
    List<Order> ordersList = await cartController.getOrders();
    setState(() {
      _orders = ordersList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cart".tr, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (BuildContext context, int index) {
          Order order = _orders[index];
          return Dismissible(
            key: ValueKey(order.id),
            child: Card(
              elevation: 0.5,
              child: ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text("BookId : ${order.id}"),
                trailing: Text("${order.price! * order.qty!} USD"),
                subtitle: Text("19-06-2025"),
              ),
            ),
            confirmDismiss: (DismissDirection direction) async {
              final alert = AlertDialog(
                title: Icon(Icons.delete, size: 30, color: Colors.red),
                content: Text("Are you sure you want to delete this item?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      cartController.removeFromCart(order.id!);
                      loadOrder();
                      Navigator.pop(context);
                    },
                    child: Text("Yes"),
                  ),
                ],
              );
              showDialog(
                context: (context),
                builder: (BuildContext context) => alert,
              );
            },
          );
        },
      ),
    );
  }
}
