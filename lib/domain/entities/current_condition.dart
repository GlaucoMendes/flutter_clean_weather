import 'package:flutter_clean_weather/core/enums/weather_icons_enum.dart';

class CurrentCondition {
  final WeatherIcons? weatherIcon;
  final String? assetIcon;
  final String weatherText;
  final double temperature;

  CurrentCondition({
    required this.weatherText,
    required this.temperature,
    this.weatherIcon,
    this.assetIcon,
  });
}
