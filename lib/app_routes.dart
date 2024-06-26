import 'package:bhc_housing_project/ui/pages/faqs.dart';
import 'package:bhc_housing_project/ui/pages/home.dart';
import 'package:bhc_housing_project/ui/pages/login.dart';
import 'package:bhc_housing_project/ui/pages/signup.dart';
import 'package:bhc_housing_project/ui/pages/splash_screen.dart';
import 'package:bhc_housing_project/ui/pages/faqs.dart';
import 'package:bhc_housing_project/ui/pages/housingdevelopements.dart';
import 'package:bhc_housing_project/ui/pages/eligibilitycriteria.dart';
import 'package:bhc_housing_project/ui/pages/bhcproducts.dart';
import 'package:bhc_housing_project/ui/pages/applicationprocdeures.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String splash = '/splash';
  static const String faqs = '/faqs';
  static const String bhcProducts = '/bhc-products';
  static const String applicationProcedures = '/application-procedures';
  static const String eligibilityCriteria = '/eligibility-criteria';
  static const String housingDevelopments = '/housing-developments';

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
      case bhcProducts:
        return MaterialPageRoute(builder: (_) => const BhcProductsPage());
      case housingDevelopments:
        return MaterialPageRoute(
            builder: (_) => const HousingDevelopmentsPage());
      case eligibilityCriteria:
        return MaterialPageRoute(
            builder: (_) => const EligibilityCriteriaPage());
      case applicationProcedures:
        return MaterialPageRoute(builder: (_) => const Applicationprocdeures());
      case faqs:
        return MaterialPageRoute(builder: (_) => const FaqPage());
      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
  }
}
