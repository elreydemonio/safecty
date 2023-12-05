import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData lightTheme = _themeData(_lightColorScheme);

  static ThemeData _themeData(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      useMaterial3: true,
    );
  }

  static const ColorScheme _lightColorScheme = ColorScheme.light();

  static final ThemeData darkTheme = ThemeData();
}
