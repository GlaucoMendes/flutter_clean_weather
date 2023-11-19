import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository.dart';
import 'package:flutter_clean_weather/domain/entities/current_condition.dart';

class GetCurrentConditionUsecase {
  final WeatherRepository repository;

  GetCurrentConditionUsecase(this.repository);

  Future<Result<CurrentCondition, Failure>> call(String id) async {
    return repository.getCurrentCondition(id);
  }
}
