import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

class GetLocationByGeoPositionUsecase {
  final WeatherRepository repository;

  GetLocationByGeoPositionUsecase({required this.repository});

  Future<Result<Location, Failure>> call(double lat, double long) {
    return repository.getLocationByGeoPosition(lat, long);
  }
}
