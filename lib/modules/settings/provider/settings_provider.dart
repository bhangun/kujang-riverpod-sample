import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = ChangeNotifierProvider<SettingsProvider>((ref) => SettingsProvider());

class SettingsProvider extends ChangeNotifier {

  bool isLightTheme = true;

  Locale locale = const Locale('en', 'EN');


  final List<Locale> supportedLocales = [
      const Locale('en', 'EN'),
      const Locale('id', 'ID'),
    ];
  

  switchTheme() {
    isLightTheme = isLightTheme ? false:true;
    notifyListeners();
  }

  switchLocale(String flag) {
    locale = Locale(flag.toLowerCase(), flag);
    notifyListeners();
  }
}
