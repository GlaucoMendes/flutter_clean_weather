import 'package:flutter_clean_weather/domain/entities/location.dart';

abstract class WeatherRemoteDatasource {
  Future<Location> getLocationByString(String text);
}