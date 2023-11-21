import 'package:flutter_clean_weather/core/enums/weather_icons_enum.dart';

class Forecast {
  final List<DailyForecast> dailyForecasts;

  Forecast({
    required this.dailyForecasts,
  });
}

class DailyForecast {
  final DateTime date;
  final double minTemp;
  final double maxTemp;

  final WeatherIcons? iconDay;
  final WeatherIcons? iconNight;

  final String? assetIconDay;
  final String? assetIconNight;

  DailyForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    this.iconDay,
    this.iconNight,
    this.assetIconDay,
    this.assetIconNight,
  });
}
