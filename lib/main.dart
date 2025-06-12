import 'package:flutter/material.dart';
import 'package:mad_2_412/route/app_route.dart';
import 'package:mad_2_412/screens/splash_screen.dart';

void main() {
  // This is the entry point of the application. The runApp function takes a
  WidgetsFlutterBinding.ensureInitialized();

  final app = App();

  runApp(app);
    
}
  
class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD II-412',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoute.splash,
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,
      debugShowCheckedModeBanner: false
    );
  }
}