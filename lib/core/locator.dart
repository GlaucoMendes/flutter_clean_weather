import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/remote/accu_remote_datasource_impl.dart';
import '../data/datasources/remote/wapi_remote_datasource_impl.dart';
import '../data/datasources/remote/weather_remote_datasource.dart';
import '../data/repositories/weather_repository.dart';
import '../data/repositories/weather_repository_impl.dart';
import '../domain/usecases/conditions/get_current_condition_usecase.dart';
import '../domain/usecases/forecast/get_forecast_by_id_usecase.dart';
import '../domain/usecases/locations/get_location_by_geoposition_usecase.dart';
import '../domain/usecases/locations/get_location_by_string_usecase.dart';
import 'core.dart';
import 'enums/weather_api_enum.dart';

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
        instanceName: WeatherApi.accuweather.instanceName,
      )
      ..registerLazySingleton<WeatherRemoteDatasource>(
        () => WapiRemoteDatasourceImpl(dio: _getIt.dio.wapi),
        instanceName: WeatherApi.weatherapi.instanceName,
      );
  }

  static void _registerRepositories() {
    _getIt.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(remoteDatasource: _getIt(instanceName: WeatherApi.weatherapi.instanceName)),
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
      ..registerLazySingleton<Dio>(() => accuDio, instanceName: WeatherApi.accuweather.instanceName)
      ..registerLazySingleton<Dio>(() => wapiDio, instanceName: WeatherApi.weatherapi.instanceName);
  }

  static Future<void> updateWeatherRepository(WeatherApi api) async {
    await _getIt.unregister<WeatherRepository>();
    _getIt.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(remoteDatasource: _getIt(instanceName: api.instanceName)),
    );
  }
}
