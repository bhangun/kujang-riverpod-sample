// General
import 'package:flutter/material.dart';

const appName = 'Kujang Apps';

// Caution! use your host IP instead of LOCALHOST
// because it not recognize on emulator

const baseURL = 'http://localhost/';
const api = '${baseURL}api/';

List<String> contentTypes = [
  "application/json",
  "application/xml",
  "application/x-www-form-urlencoded"
];

String contentType =
    contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

// Authentication
const token = "token";

// Store Name
String storeName = 'kujang';

// DB Name
const dbName = 'kujang.db';

// Fields
const fieldId = 'id';

// Timeout
const int timeoutReceive = 5000;
const int timeoutConnection = 5000;

// Icon Images
const String iconApp = 'assets/icons/ic_appicon.png';
const String imageLogin = 'assets/images/img_login.jpg';
const String imageSplash = 'assets/icons/logo-kujang.svg';

enum Flavor {
  DEVELOPMENT,
  RELEASE,
}

class Config {
  static Flavor appFlavor = Flavor.DEVELOPMENT;

  static String get flavor {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return 'RELEASE';
      case Flavor.DEVELOPMENT:
      default:
        return 'DEVELOPMENT';
    }
  }

  static Icon get flavorIcon {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return const Icon(Icons.new_releases);
      case Flavor.DEVELOPMENT:
      default:
        return const Icon(Icons.developer_mode);
    }
  }
}
