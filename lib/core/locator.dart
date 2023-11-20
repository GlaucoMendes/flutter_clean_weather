import 'package:dio/dio.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/datasources/remote/accu_remote_datasource_impl.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_weather/domain/usecases/conditions/get_current_condition_usecase.dart';
import 'package:flutter_clean_weather/domain/usecases/forecast/get_forecast_by_id_usecase.dart';
import 'package:flutter_clean_weather/domain/usecases/locations/get_location_by_geoposition_usecase.dart';
import 'package:flutter_clean_weather/domain/usecases/locations/get_location_by_string_usecase.dart';
import 'package:get_it/get_it.dart';

class Locator {
  Locator._();
  static final GetIt _getIt = GetIt.instance;
  static void init() {
    _registerDio();
    _registerDatasources();
    _registerRepositories();
    _registerUseCases();
  }

  static void _registerDatasources() {
    _getIt.registerLazySingleton<WeatherRemoteDatasource>(() => AccuRemoteDatasourceImpl(dio: _getIt.dio.accu));
  }

  static void _registerRepositories() {
    _getIt.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(remoteDatasource: _getIt()));
  }

  static void _registerUseCases() {
    _getIt
      ..registerLazySingleton(() => GetLocationByStringUsecase(repository: _getIt()))
      ..registerLazySingleton(() => GetLocationByGeoPositionUsecase(repository: _getIt()))
      ..registerLazySingleton(() => GetForecastByIdUsecase(repository: _getIt()))
      ..registerLazySingleton(() => GetCurrentConditionUsecase(_getIt()));
  }

  static void _registerDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://dataservice.accuweather.com',
        queryParameters: {
          // TODO(Glauco): Move this to a config file
          'apikey': 'G02RRIZs8fE6Smw83FMrFQTFBb8cqsv4',
        },
      ),
    );
    _getIt.registerLazySingleton<Dio>(() => dio, instanceName: 'accuwather');
  }
}
