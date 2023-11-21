import '../../../core/core.dart';
import '../../../data/repositories/weather_repository.dart';
import '../../entities/location.dart';

class GetLocationByGeoPositionUsecase {
  final WeatherRepository repository;

  GetLocationByGeoPositionUsecase({required this.repository});

  Future<Result<Location, Failure>> call(double lat, double long) {
    return repository.getLocationByGeoPosition(lat, long);
  }
}
