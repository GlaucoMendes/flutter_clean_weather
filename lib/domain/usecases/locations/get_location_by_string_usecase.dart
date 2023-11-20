import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

class GetLocationByStringUsecase {
  final WeatherRepository repository;

  GetLocationByStringUsecase({required this.repository});

  Future<Result<List<Location>, Failure>> call(String text) {
    return repository.getLocationByString(text);
  }
}
