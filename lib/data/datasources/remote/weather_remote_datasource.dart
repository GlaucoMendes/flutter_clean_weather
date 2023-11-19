import 'package:flutter_clean_weather/domain/entities/current_condition.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

abstract class WeatherRemoteDatasource {
  Future<Location> getLocationByString(String text);
  Future<Location> getLocationByGeoPosition(double lat, double long);
  Future<Forecast> getForecastById(String id);
  Future<CurrentCondition> getCurrentCondition(String id);
}
