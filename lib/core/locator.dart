import 'package:dio/dio.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/datasources/remote/accu_remote_datasource_impl.dart';
import 'package:flutter_clean_weather/data/datasources/remote/wapi_remote_datasource_impl.dart';
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
    _getIt
      ..registerLazySingleton<WeatherRemoteDatasource>(
        () => AccuRemoteDatasourceImpl(dio: _getIt.dio.accu),
        instanceName: 'accuDatasource',
      )
      ..registerLazySingleton<WeatherRemoteDatasource>(
        () => WapiRemoteDatasourceImpl(dio: _getIt.dio.wapi),
        instanceName: 'wapiDatasource',
      );
  }

  static void _registerRepositories() {
    _getIt.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(remoteDatasource: _getIt(instanceName: 'wapiDatasource')),
    );
  }

  static void _registerUseCases() {
    _getIt
      ..registerLazySingleton(() => GetLocationByStringUsecase(repository: _getIt()))
      ..registerLazySingleton(() => GetLocationByGeoPositionUsecase(repository: _getIt()))
      ..registerLazySingleton(() => GetForecastByIdUsecase(repository: _getIt()))
      ..registerLazySingleton(() => GetCurrentConditionUsecase(_getIt()));
  }

  static void _registerDio() {
    final accuDio = Dio(
      BaseOptions(
        baseUrl: 'https://dataservice.accuweather.com',
        queryParameters: {
          // TODO(Glauco): Move this to a config file
          'apikey': 'G02RRIZs8fE6Smw83FMrFQTFBb8cqsv4',
        },
      ),
    );
    final wapiDio = Dio(
      BaseOptions(
        baseUrl: 'http://api.weatherapi.com/v1/',
        queryParameters: {
          // TODO(Glauco): Move this to a config file
          'key': '13e13b1293c348c1968230607231611',
        },
      ),
    );
    _getIt
      ..registerLazySingleton<Dio>(() => accuDio, instanceName: 'accuweather')
      ..registerLazySingleton<Dio>(() => wapiDio, instanceName: 'weatherapi');
  }
}
