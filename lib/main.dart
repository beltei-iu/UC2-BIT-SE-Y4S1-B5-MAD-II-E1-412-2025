import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_412/controller/book_controller.dart';
import 'package:mad_2_412/model/book.dart';
import 'package:mad_2_412/route/app_route.dart';
import 'package:mad_2_412/screens/splash_screen.dart';
import 'package:mad_2_412/translate/Message.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase Config
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final bookController = Get.put(BookController());
  // final book = Book(
  //   title: "Khmer Dictionary",
  //   author: "Chun Nat",
  //   description: "Khmer Dictionary",
  //   price: 10000,
  //   discount: 10,
  // );
  // bookController.addBook(book);

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MAD II-412',
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,
      home: SplashScreen(),
      // Theme
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // Translate
      fallbackLocale: Locale("en", "US"),
      locale: Get.deviceLocale,
      translations: Message(),
    );
  }
}
