import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class PlatformInfo {
  static const _desktopPlatforms = [TargetPlatform.macOS, TargetPlatform.windows, TargetPlatform.linux];
  static const _mobilePlatforms = [TargetPlatform.android, TargetPlatform.iOS];

  static bool get isDesktop => _desktopPlatforms.contains(defaultTargetPlatform) && !kIsWeb;
  static bool get isDesktopOrWeb => isDesktop || kIsWeb;
  static bool get isMobile => _mobilePlatforms.contains(defaultTargetPlatform) && !kIsWeb;


  static bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;
  static bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;
  static bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  // static Future<bool> get isConnected async => await InternetConnectionChecker().hasConnection;
  // static Future<bool> get isDisconnected async => (await isConnected) == false;
  // static connectivityResult = await (Connectivity().checkConnectivity());


  static Future<bool> get isMobileInternet async => await Connectivity().checkConnectivity().then((value) => value == ConnectivityResult.mobile);
  static Future<bool> get isWifi async => await Connectivity().checkConnectivity().then((value) => value == ConnectivityResult.wifi);

}

/* 
import 'package:connectivity_plus/connectivity_plus.dart';

@override
initState() {
  super.initState();

  subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    // Got a new connectivity status!
  })
}

// Be sure to cancel subscription after you are done
@override
dispose() {
  super.dispose();

  subscription.cancel();
} */
