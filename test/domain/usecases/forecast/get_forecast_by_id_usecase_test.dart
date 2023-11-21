import 'dart:convert';
import 'dart:io';

import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:flutter_clean_weather/data/dtos/accu/forecast_dto.dart';
import 'package:flutter_clean_weather/data/mappers/accu/forecast_mapper.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';
import 'package:flutter_clean_weather/domain/usecases/forecast/get_forecast_by_id_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRemoteDatasource extends Mock implements WeatherRemoteDatasource {}

void main() async {
  late GetForecastByIdUsecase usecase;
  late MockWeatherRemoteDatasource datasource;
  late WeatherRepository repository;

  setUp(() {
    datasource = MockWeatherRemoteDatasource();
    repository = WeatherRepositoryImpl(remoteDatasource: datasource);
    usecase = GetForecastByIdUsecase(repository: repository);
  });

  final mock = await File('test/mocks/accu/forecasts/forecast.json').readAsString();
  final forecastDTO = ForecastDTO.fromJson(jsonDecode(mock) as Map<String, dynamic>);

  group('Get Forecast by GetForecastByIdUsecase', () {
    test('Checks if the GetForecastByIdUsecase successfully returns a Forecast instance when valid data is provided.',
        () async {
      when(() => datasource.getForecastById(any())).thenAnswer((_) async => ForecastMapper.fromDTO(forecastDTO));
      final result = await usecase.call('');

      expect(result.isSuccess(), true);
      expect(result.tryGetSuccess(), isA<Forecast>());
      verify(() => datasource.getForecastById(any<String>())).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test(
        'Confirms that an EmptyDataFailure is returned when the datasource finds no data, indicating an empty response.',
        () async {
      when(() => datasource.getForecastById(any<String>())).thenThrow(EmptyDataFailure());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<EmptyDataFailure>());
      verify(() => datasource.getForecastById(any<String>())).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test('Ensures that a RequestFailure is returned when the datasource encounters a request error.', () async {
      when(() => datasource.getForecastById(any<String>())).thenThrow(RequestFailure());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<RequestFailure>());
      verify(() => datasource.getForecastById(any<String>())).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test('Checks if a DtoConversionFailure is thrown when there is a DTO conversion error by the datasource', () async {
      when(() => datasource.getForecastById(any<String>())).thenThrow(DtoConversionFailure());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<DtoConversionFailure>());
      verify(() => datasource.getForecastById(any<String>())).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test('Confirms that an UnknownFailure is returned for unspecified errors caught by the datasource.', () async {
      when(() => datasource.getForecastById(any<String>())).thenThrow(UnknownFailure());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<UnknownFailure>());
      verify(() => datasource.getForecastById(any<String>())).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test('Tests if a generic exception is treated as an UnknownFailure', () async {
      when(() => datasource.getForecastById(any<String>())).thenThrow(Exception());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<UnknownFailure>());
      verify(() => datasource.getForecastById(any<String>())).called(1);
      verifyNoMoreInteractions(datasource);
    });
  });
}
