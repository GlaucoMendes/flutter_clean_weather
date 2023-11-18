import 'package:flutter/material.dart';

class WeatherThemeData {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.white,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF161616),
      onPrimary: Colors.white,
      secondary: Color(0xFF323232),
    ),
  );
}
