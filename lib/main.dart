import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_412/data/file_storage_data.dart';
import 'package:mad_2_412/data/sqflite_db_data.dart';
import 'package:mad_2_412/provider/cart_provider.dart';
import 'package:mad_2_412/route/app_route.dart';
import 'package:mad_2_412/translate/Message.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SqfliteDbData.instance.database;

  //
  // final app = EasyLocalization(
  //     child: App(),
  //     supportedLocales: [
  //       Locale("en",""),
  //       Locale("km","")
  //     ],
  //     useOnlyLangCode: true,
  //     path: "assets/translations",
  //     fallbackLocale: Locale('en', ''),
  // );

  final app = App();
  runApp(app);
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MAD II-412',
      // Theme
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Get.isDarkMode? ThemeMode.dark : ThemeMode.light,
      // End Theme
      initialRoute: AppRoute.splash,
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,

      fallbackLocale: Locale("en","US"),
      locale: Get.deviceLocale,
      translations: Message(),
    );
  }
}
