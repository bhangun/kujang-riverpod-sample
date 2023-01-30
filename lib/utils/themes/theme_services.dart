import 'package:flutter/material.dart';

import 'material_theme_colors.dart';

class ThemeServices {

static TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    titleLarge: base.titleLarge!.copyWith(
        fontSize: 18.0
    ),
    bodySmall: base.bodySmall!.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
    bodyMedium: base.bodyMedium!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),
  ).apply(
    // fontFamily: 'ProductSans',
    displayColor: MatThemeColors.black,
    bodyColor: MatThemeColors.black,
  );
}


static ThemeData darkTheme() {
  Color primaryColor = MatThemeColors.lime[900]!;
  Color secondaryColor = MatThemeColors.lime[200]!;
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    primaryColor: primaryColor,
    primaryColorDark: primaryColor,
    primaryColorLight: secondaryColor,
    indicatorColor: Colors.white,
    canvasColor: const Color(0xFF202124),
    scaffoldBackgroundColor: const Color(0xFF202124),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ), colorScheme: ColorScheme.fromSwatch(primarySwatch: MatThemeColors.deepPurple).copyWith(background: const Color(0xFFB00020)),
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
  );
}

static ThemeData lightTheme() {
  Color primaryColor = MatThemeColors.green[600]!;
  Color secondaryColor = MatThemeColors.lime[100]!;
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    primarySwatch:MatThemeColors.amber,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    indicatorColor: Colors.white,
    // toggleableActiveColor: const Color(0xFF1E88E5),
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    // backgroundColor: Colors.white,
    // errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
  );
  }
}