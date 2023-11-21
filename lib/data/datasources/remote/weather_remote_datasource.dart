import '../../../domain/entities/current_condition.dart';
import '../../../domain/entities/forecast.dart';
import '../../../domain/entities/location.dart';

abstract class WeatherRemoteDatasource {
  Future<List<Location>> getLocationByString(String text);
  Future<Location> getLocationByGeoPosition(double lat, double long);
  Future<Forecast> getForecastById(String id);
  Future<CurrentCondition> getCurrentCondition(String id);
}
