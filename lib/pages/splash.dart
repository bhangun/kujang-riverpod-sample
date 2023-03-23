import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main_routes.dart';
import '../utils/config.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  State<StatefulWidget> createState() => _Splashpagestate();
}

class _Splashpagestate extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: SvgPicture.asset(imageSplash)),
    );
  }

  startTimer() {
    var duration = const Duration(milliseconds: 3000);
    return Timer(duration, navigate);
  }

  navigate() async {
    Navigator.of(context).pushReplacementNamed(MainRoutes.login);
  }
}
