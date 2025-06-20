import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mad_2_412/data/file_storage_data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart"), centerTitle: true, elevation: 0.5),
      body: FutureBuilder(
        future: FileStorageData.readDataFromFile(),
        builder:
            (BuildContext context, AsyncSnapshot<List<String>> asyncSnapshot) {
              // Waiting
              if (asyncSnapshot.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              }

              // Error
              if (asyncSnapshot.hasError) {
                return Center(child: Text("Error: ${asyncSnapshot.error}"));
              }

              // No Record
              if (!asyncSnapshot.hasData) {
                return Center(child: Text("No data"));
              }

              List<String> cartItems = asyncSnapshot.data as List<String>;

              return ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (BuildContext context, int index) {
                  // bookId=0,price=20000.0,qty=1,discount=0
                  String data = cartItems[index];
                  List<String> dataOrder = data.split(",");
                  String bookId = dataOrder[0];
                  double price = double.parse(dataOrder[1].split("=")[1]);

                  return Card(
                    elevation: 0.5,
                    child: ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text("BookId : $bookId"),
                      trailing: Text("$price USD"),
                      subtitle: Text("19-06-2025"),
                    ),
                  );
                },
              );
            },
      ),
    );
  }
}
