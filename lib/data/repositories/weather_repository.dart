import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

abstract class WeatherRepository {
  Future<Result<Location, Failure>> getLocationByString(String text);
}
