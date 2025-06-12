import 'package:flutter/material.dart';
import 'package:mad_2_412/screens/login_screen.dart';
import 'package:mad_2_412/screens/main_screen.dart';
import 'package:mad_2_412/screens/otp_confirm_screen.dart';
import 'package:mad_2_412/screens/otp_screen.dart';
import 'package:mad_2_412/screens/register_screen.dart';
import 'package:mad_2_412/screens/splash_screen.dart';

class AppRoute {

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String otpConfirm = '/otpConfirm';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String help = '/help';
  static const String terms = '/terms';
  static const String privacy = '/privacy';

  static final key = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(settings, SplashScreen());
      case login:
        return _buildRoute(settings, LoginScreen());
      case register:
        return _buildRoute(settings, RegisterScreen());
      case otp:
        return _buildRoute(settings, OtpScreen());
      case otpConfirm:
        return _buildRoute(settings, OtpConfirmScreen());
      case home:
        return _buildRoute(settings, MainScreen());

      default:
        throw Exception('Route not found: ${settings.name}');
    }
  }

  static Route<dynamic> _buildRoute(RouteSettings settings, Widget newScreen) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => newScreen,
    );
  }
}

