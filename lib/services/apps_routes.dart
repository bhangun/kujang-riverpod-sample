import 'package:flutter/material.dart';
import '../modules/settings/pages/about.dart';
import '../modules/app/pages/home.dart';
import '../modules/auth/pages/login.dart';
import '../modules/app/pages/splash.dart';

class AppsRoutes {
  AppsRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String about = '/about';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => const SplashScreen(),
    login: (BuildContext context) => const LoginScreen(),
    home: (BuildContext context) => const HomePage(),
    about: (BuildContext context) => AboutPage(),
  };
}
