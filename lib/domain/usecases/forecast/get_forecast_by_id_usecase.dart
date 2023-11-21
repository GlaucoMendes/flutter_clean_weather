import '../../../core/core.dart';
import '../../../data/repositories/weather_repository.dart';
import '../../entities/forecast.dart';

class GetForecastByIdUsecase {
  final WeatherRepository repository;
  GetForecastByIdUsecase({required this.repository});

  Future<Result<Forecast, Failure>> call(String id) async {
    return repository.getForecastById(id);
  }
}
