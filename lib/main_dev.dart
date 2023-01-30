import 'package:flutter/material.dart';
import 'package:riverpod_sample/main.dart';

import 'utils/config.dart';


void main() {
  Config.appFlavor = Flavor.DEVELOPMENT;
  runApp(const KujangApp());
}