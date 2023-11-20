import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository.dart';
import 'package:flutter_clean_weather/domain/entities/current_condition.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource remoteDatasource;

  WeatherRepositoryImpl({required this.remoteDatasource});

  Future<Result<T, Failure>> _execute<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Success(result);
    } on EmptyDataFailure catch (e) {
      return Error(e);
    } on RequestFailure catch (e) {
      return Error(e);
    } on DtoConversionFailure catch (e) {
      return Error(e);
    } on UnknownFailure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<Location>, Failure>> getLocationByString(String text) async {
    return _execute(() => remoteDatasource.getLocationByString(text));
  }

  @override
  Future<Result<Location, Failure>> getLocationByGeoPosition(double lat, double long) async {
    return _execute(() => remoteDatasource.getLocationByGeoPosition(lat, long));
  }

  @override
  Future<Result<Forecast, Failure>> getForecastById(String id) async {
    return _execute(() => remoteDatasource.getForecastById(id));
  }

  @override
  Future<Result<CurrentCondition, Failure>> getCurrentCondition(String id) {
    return _execute(() => remoteDatasource.getCurrentCondition(id));
  }
}
