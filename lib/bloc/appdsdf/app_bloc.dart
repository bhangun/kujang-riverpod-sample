import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/services/apps_routes.dart';
import 'package:riverpod_sample/services/navigation.dart';
import 'package:riverpod_sample/utils/themes/theme_services.dart';


final appsBloc = ChangeNotifierProvider<AppsBloc>((ref) => AppsBloc());


class AppsBloc extends ChangeNotifier {
  bool isLightTheme = false;

  bool isLocale = true;

  ThemeData theme = ThemeServices.lightTheme();

  Locale locale = const Locale('en', 'EN');

  String errorMessage = 'error';

  String userMessage = 'user message';

  String passwordMessage = 'user message';

  String forgotMessage = 'user message';
  bool showError = false;

  final supportedLocalesProvider = Provider<List<Locale>>((_) {
    return const [
      Locale('en', 'US'),
      Locale('id', 'EN'),
    ];
  });

  void setLightTheme() {
    isLightTheme = true;
    notifyListeners();
  }

  void setDarkTheme() {
    isLightTheme = false;
    notifyListeners();
  }

  void setLocale() {
    isLightTheme = false;
    notifyListeners();
  }
  switchTheme() {
    isLightTheme = isLightTheme ? false : true;
    notifyListeners();
  }

  Future<void> switchLocale(String flag) async {
    locale = Locale(flag.toLowerCase(), flag);
    notifyListeners();
  }

  forgotPassword() {}

  login() {}

  goTo(int index) {
    switch (index) {
      case 0:
        NavigationServices.navigateTo(AppsRoutes.home);
        break;
      default:
    }
  }

  void dispose() {}
}
