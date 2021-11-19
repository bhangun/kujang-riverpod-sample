import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsBloc = ChangeNotifierProvider<SettingsBloc>((ref) => SettingsBloc());

class SettingsBloc extends ChangeNotifier {

  bool isLightTheme = true;

  Locale locale = const Locale('en', 'EN');

  final supportedLocalesProvider = Provider<List<Locale>>((_) {
    return const [
      Locale('en', 'EN'),
      Locale('id', 'ID'),
    ];
  });

  final List<Locale> supportedLocales = [
      const Locale('en', 'EN'),
      const Locale('id', 'ID'),
    ];
  

  switchTheme() {
    isLightTheme = isLightTheme ? false:true;
    notifyListeners();
  }

  Future<void> switchLocale(String flag) async => locale = Locale(flag.toLowerCase(), flag);
  
}
