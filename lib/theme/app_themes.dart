import 'package:flutter/material.dart';
import 'package:safecty/theme/font_family.dart';

import 'app_colors.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData lightTheme = _themeData(_lightColorScheme);

  static ThemeData _themeData(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      useMaterial3: true,
    );
  }

  static const ColorScheme _lightColorScheme = ColorScheme.light(
    background: AppColors.filOnWhiteBone,
    brightness: Brightness.light,
    error: AppColors.filOnBlack,
    onBackground: Colors.white,
    onError: AppColors.filOnBlack,
    onPrimary: AppColors.filOnBlack,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    primary: AppColors.filOnDarkBeige,
    primaryContainer: Color(0xFF253A2C),
    secondary: Color(0xFFEFF3F3),
    secondaryContainer: Color(0xFF607162),
    surface: Color(0xFFFAFBFB),
  );

  static final ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(),
    colorScheme: const ColorScheme.dark(),
    elevatedButtonTheme: const ElevatedButtonThemeData(),
    fontFamily: AppFontFamily.quicksand,
    iconTheme: const IconThemeData(),
    scaffoldBackgroundColor: AppColors.filOnGreen,
    snackBarTheme: const SnackBarThemeData(),
    textButtonTheme: const TextButtonThemeData(),
    textTheme: const TextTheme(),
  );
}
