import 'package:bhc_housing_project/ui/pages/home.dart';
import 'package:bhc_housing_project/ui/pages/login.dart';
import 'package:bhc_housing_project/ui/pages/signup.dart';
import 'package:bhc_housing_project/ui/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String splash = '/splash';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const Home());
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
  }
}
