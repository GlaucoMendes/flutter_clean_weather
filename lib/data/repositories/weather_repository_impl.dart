import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource remoteDatasource;

  WeatherRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Result<Location, Failure>> getLocationByString(String text) async {
    try {
      final location = await remoteDatasource.getLocationByString(text);
      return Success(location);
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
}
