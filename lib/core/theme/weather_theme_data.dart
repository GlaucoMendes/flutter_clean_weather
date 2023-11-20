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
    buttonTheme: const ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Defina o raio desejado aqui
          ),
        ),
      ),
    ),
  );
}
