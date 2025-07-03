import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_412/data/file_storage_data.dart';
import 'package:mad_2_412/data/sqflite_db_data.dart';
import 'package:mad_2_412/provider/cart_provider.dart';
import 'package:mad_2_412/route/app_route.dart';
import 'package:provider/provider.dart';

void main() {
  // This is the entry point of the application. The runApp function takes a
  WidgetsFlutterBinding.ensureInitialized();

  // Init DB
  SqfliteDbData.instance.database;

  final app = App();

  // Provider
  // final provider = MultiProvider(providers: [
  //   ChangeNotifierProvider(create: (context) => CartProvider()),
  //   //..
  // ],
  // child: app,);
  //
  // runApp(provider);

  // GetX
  runApp(app);
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //return MaterialApp(

    // GetX
    return GetMaterialApp(
      title: 'MAD II-412',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoute.splash,
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,
    );
  }
}
