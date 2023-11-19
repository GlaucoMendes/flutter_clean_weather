import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/domain/entities/current_condition.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

abstract class WeatherRepository {
  Future<Result<Location, Failure>> getLocationByString(String text);
  Future<Result<Location, Failure>> getLocationByGeoPosition(double lat, double long);
  Future<Result<Forecast, Failure>> getForecastById(String id);
  Future<Result<CurrentCondition, Failure>> getCurrentCondition(String id);
}
