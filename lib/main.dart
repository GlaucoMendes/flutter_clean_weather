import 'package:flutter/material.dart';
import 'package:flutter_clean_weather/presentation/home/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF161616),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
    );
  }
}
