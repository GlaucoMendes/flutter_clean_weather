import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';

class GetForecastByIdUsecase {
  final WeatherRepository repository;
  GetForecastByIdUsecase({required this.repository});

  Future<Result<Forecast, Failure>> call(String id) async {
    return repository.getForecastById(id);
  }
}
