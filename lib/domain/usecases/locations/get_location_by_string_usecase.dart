import '../../../core/core.dart';
import '../../../data/repositories/weather_repository.dart';
import '../../entities/location.dart';

class GetLocationByStringUsecase {
  final WeatherRepository repository;

  GetLocationByStringUsecase({required this.repository});

  Future<Result<List<Location>, Failure>> call(String text) {
    return repository.getLocationByString(text);
  }
}
