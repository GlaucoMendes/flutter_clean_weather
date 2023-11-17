import 'package:flutter/material.dart';
import 'package:flutter_clean_weather/core/enums/weather_icons_enum.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clean Weather')),
      body: SingleChildScrollView(
        child: GridView.builder(
          itemCount: WeatherIcons.values.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            final key = WeatherIcons.values[index].toString().split('.').last;
            return Column(
              children: [
                Text(key),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Lottie.asset(
                    'assets/lotties/$key.json',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
