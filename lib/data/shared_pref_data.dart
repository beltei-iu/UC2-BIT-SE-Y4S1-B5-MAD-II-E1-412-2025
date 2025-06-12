
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefData {

  static const String EMAIL = "EMIAL";
  static const String PASSWORD = "PASSWORD";

  static Future<void> login(String email, String password) async{
    // Create SharedPreferences
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(EMAIL, email);
    await sharedPref.setString(PASSWORD, password);
  }

}