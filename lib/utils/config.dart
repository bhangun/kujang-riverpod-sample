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

const double windowWidth = 1024;
const double windowHeight = 800;



// Icon Images
const String iconApp = 'assets/icons/ic_appicon.png';
const String imageLogin = 'assets/images/img_login.jpg';
const String imageSplash = 'assets/icons/logo-mi.svg';

enum Flavor {
  development,
  release,
}

class Config {
  static Flavor appFlavor = Flavor.development;

  static String get flavor {
    switch (appFlavor) {
      case Flavor.release:
        return 'RELEASE';
      case Flavor.development:
      default:
        return 'DEVELOPMENT';
    }
  }

  static Icon get flavorIcon {
    switch (appFlavor) {
      case Flavor.release:
        return const Icon(Icons.new_releases);
      case Flavor.development:
      default:
        return const Icon(Icons.developer_mode);
    }
  }
}
