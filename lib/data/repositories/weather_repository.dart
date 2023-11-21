import '../../core/core.dart';
import '../../domain/entities/current_condition.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/entities/location.dart';

abstract class WeatherRepository {
  Future<Result<List<Location>, Failure>> getLocationByString(String text);
  Future<Result<Location, Failure>> getLocationByGeoPosition(double lat, double long);
  Future<Result<Forecast, Failure>> getForecastById(String id);
  Future<Result<CurrentCondition, Failure>> getCurrentCondition(String id);
}
