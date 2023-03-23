import 'package:flutter/material.dart';

import 'main.dart';
import 'utils/config.dart';


void main() {
  Config.appFlavor = Flavor.development;
  runApp(const KujangApp());
}