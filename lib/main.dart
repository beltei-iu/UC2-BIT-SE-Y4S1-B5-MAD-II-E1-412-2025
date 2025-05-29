import 'package:flutter/material.dart';
import 'package:mad_2_412/route/app_route.dart';
import 'package:mad_2_412/screens/splash_screen.dart';

void main() {

  // Initialize Widget
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MADII-412',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),


      // Option 1
      // home: SplashScreen(),

      // Option 2
      // routes: {

      // },

      // Option 3
      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,

    );
  }
}
