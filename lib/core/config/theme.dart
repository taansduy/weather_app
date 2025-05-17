import 'package:flutter/material.dart';
import 'package:weather/core/config/app_color.dart';

final colorScheme =ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.backgroundLight,
  onPrimary: AppColors.backgroundDark,
  surface: AppColors.backgroundLight,
  error: AppColors.errorColor,
  onError: AppColors.white,
  secondary: AppColors.backgroundLight,
  onSecondary: AppColors.backgroundDark, onSurface: AppColors.surfaceDark,
);

final ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Color(0xFFF5F6F7),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF4A4A4A),
      foregroundColor: Colors.white,
    ),
  ),
  fontFamily: 'Roboto-Regular',
  colorScheme: colorScheme,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 20, color: AppColors.backgroundDark),
    bodyMedium: TextStyle(fontSize: 16, height: 1.2, color: AppColors.backgroundDark),
    labelLarge: TextStyle(fontSize: 96, fontWeight: FontWeight.bold, height: 1.2, color: AppColors.backgroundDark),
    displayLarge: TextStyle(fontSize: 36,fontWeight: FontWeight.w100, height: 1.4, color: AppColors.backgroundDark),
  ),
);