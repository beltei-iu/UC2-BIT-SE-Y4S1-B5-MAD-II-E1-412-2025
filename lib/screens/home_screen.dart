import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_412/controller/cart_controller.dart';
import 'package:mad_2_412/data/file_storage_data.dart';
import 'package:mad_2_412/data/shared_pref_data.dart';
import 'package:mad_2_412/model/book.dart';
import 'package:mad_2_412/model/order.dart';
import 'package:mad_2_412/provider/cart_provider.dart';
import 'package:mad_2_412/services/book_service.dart';
import 'package:mad_2_412/services/order_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? fullName = "Guest";

  final _cartTotal = 0.obs;
  List<Book> _books = [];
  final orderService = OrderService.instance;
  final cartController = Get.put(CartController());

  final bookServicce = BookService();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _loadUser();
    _getBooks();
    _loadOrderItems();
  }

  Future<void> _getBooks() async {
    final bookService = BookService();

    // for (int i = 0; i < 4; i++) {
    //   final book = Book(
    //     title: "Book $i",
    //     author: "Author $i",
    //     description: "Description $i",
    //     price: 20000,
    //     discount: 0,
    //   );
    //   bookService.insertBook(book);
    // }

    List<Book> books = await bookService.getBooksFromFirebase();
    print("Book : ${books.length}");
    setState(() {
      _books = books;
    });
  }

  Future<void> _loadOrderItems() async {
    List<Order> orders = await cartController.getOrders();
    setState(() {
      _cartTotal.value = orders.length ?? 0;
    });
  }

  Future<void> _loadCartOrder() async {
    // Option 1
    //List<String> data = await FileStorageData.readDataFromFile();

    // Option 2
    // await FileStorageData.readDataFromFile()
    //     .then((List<String> data) {
    //       setState(() {
    //         _cartTotal = data.length;
    //       });
    //     })
    //     .then((error) {
    //       print("Error loading data");
    //     });
  }

  Future<void> _loadUser() async {
    final User? user = _auth.currentUser;
    setState(() {
      fullName = user!.email!.split("@")[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    //final cartProvider = Provider.of<CartProvider>(context, listen: true);
    //_loadOrderItems(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("hi".tr + " $fullName"),
        backgroundColor: Colors.white,

        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            showBadge: true,
            badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
            badgeContent: Obx(
              () => Text(
                "${cartController.cartTotal}",
                style: TextStyle(color: Colors.white),
              ),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          _searchWidget,
          _sliderWidget,
          _bookTitle,
          _booksWidget,
          _bookRecommendTitle,
          _booksRecommendWidget,
        ],
      ),
    );
  }

  Widget get _searchWidget {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
        ),
        onChanged: (value) {
          print("Searching for: $value");
        },
      ),
    );
  }

  Widget get _sliderWidget {
    List<Widget> images = List.generate(3, (i) {
      return Image.asset(
        "assets/images/HQ.png",
        height: 200,
        fit: BoxFit.cover,
      );
    }).toList();

    return SizedBox(
      height: 200,
      child: CarouselView(
        elevation: 2,
        itemSnapping: true,
        itemExtent: double.infinity,
        children: images,
      ),
    );
  }

  Widget get _bookTitle {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Top Book", style: TextStyle(fontWeight: FontWeight.bold)),
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }

  Widget get _bookRecommendTitle {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Recommend Book", style: TextStyle(fontWeight: FontWeight.bold)),
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }

  Widget get _booksWidget {
    // List<Widget> _bookItems = List.generate(10, (index) {
    //   return _bookCartItem(index);
    // }).toList();

    List<Widget> _bookItems = _books.map((e) => _bookCartItem(e)).toList();

    // Option 1  : Using ListView
    // return SizedBox(
    //   height: 220,
    //   child: ListView(scrollDirection: Axis.horizontal, children: _bookItems),
    // );

    // Option 2 : Using Row
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: _bookItems),
    );
  }

  Widget _bookCartItem(Book book) {
    return Card(
      child: Column(
        children: [
          Image.asset("assets/images/book.png", height: 180),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  final alert = AlertDialog(
                    title: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 40,
                    ),
                    content: Text(
                      "You have successfully added the book to your cart",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          //Navigator.of(context).pop();
                          // Using Getx
                          Get.back();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );

                  // final orderReq = Order(
                  //   bookId: book.id,
                  //   qty: 1,
                  //   price: book.price,
                  // );
                  //orderService.insertOrder(orderReq);
                  //cartController.addToCart(orderReq);
                  showDialog(context: context, builder: (context) => alert);
                },
                child: Icon(Icons.add),
              ),
              Text("1"),
              TextButton(onPressed: () {}, child: Icon(Icons.remove)),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _booksRecommendWidget {
    // List<Widget> _bookItems = List.generate(10, (index) {
    //   return _bookCartItem(index);
    // }).toList();

    List<Widget> _bookItems = _books
        .map((e) => _bookCartRecommendItem(e))
        .toList();

    // Option 1  : Using ListView
    // return SizedBox(
    //   height: 220,
    //   child: ListView(scrollDirection: Axis.horizontal, children: _bookItems),
    // );

    // Option 2 : Using Row
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: _bookItems),
    );
  }

  Widget _bookCartRecommendItem(Book book) {
    return Card(
      child: Column(
        children: [
          Image.asset("assets/images/book2.jpg", height: 180),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  final alert = AlertDialog(
                    title: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 40,
                    ),
                    content: Text(
                      "You have successfully added the book to your cart",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );

                  // final orderReq = Order(
                  //   bookId: book.id,
                  //   qty: 1,
                  //   price: book.price,
                  // );
                  // orderService.insertOrder(orderReq);
                  // cartController.addToCart(orderReq);

                  showDialog(context: context, builder: (context) => alert);
                },
                child: Icon(Icons.add),
              ),
              Text("1"),
              TextButton(onPressed: () {}, child: Icon(Icons.remove)),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _orderBook({
    int? bookId,
    double? price,
    int? qty,
    int? discount,
  }) async {
    // bookId=1,price=20000,qty=1,discount=0
    String data = "bookId=$bookId,price=$price,qty=$qty,discount=$discount";
    //await FileStorageData.writeDataToFile(data);
  }
}
