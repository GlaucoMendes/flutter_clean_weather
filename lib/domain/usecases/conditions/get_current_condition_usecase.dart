import '../../../core/core.dart';
import '../../../data/repositories/weather_repository.dart';
import '../../entities/current_condition.dart';

class GetCurrentConditionUsecase {
  final WeatherRepository repository;

  GetCurrentConditionUsecase(this.repository);

  Future<Result<CurrentCondition, Failure>> call(String id) async {
    return repository.getCurrentCondition(id);
  }
}
