import 'package:flutter/material.dart';
import 'package:mad_2_412/screens/cart_screen.dart';
import 'package:mad_2_412/screens/favorite_screen.dart';
import 'package:mad_2_412/screens/home_screen.dart';
import 'package:mad_2_412/screens/more_screen.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: screens[_currentIndex], bottomNavigationBar: _navBar);
  }

  Widget get _navBar {

    var home = 'home'.tr;


    return BottomNavigationBar(
      currentIndex: _currentIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.blue,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "home".tr),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "favorite".tr),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'cart'.tr),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_vert),
          label: 'more'.tr,
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
