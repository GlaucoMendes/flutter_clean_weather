import 'dart:convert';
import 'dart:io';

import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:flutter_clean_weather/data/dtos/accu/current_condition_dto.dart';
import 'package:flutter_clean_weather/data/mappers/accu/current_condition_mapper.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_weather/domain/entities/current_condition.dart';
import 'package:flutter_clean_weather/domain/usecases/conditions/get_current_condition_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRemoteDatasource extends Mock implements WeatherRemoteDatasource {}

void main() async {
  late GetCurrentConditionUsecase usecase;
  late WeatherRemoteDatasource datasource;
  late WeatherRepository repository;

  setUp(() {
    datasource = MockWeatherRemoteDatasource();
    repository = WeatherRepositoryImpl(remoteDatasource: datasource);
    usecase = GetCurrentConditionUsecase(repository);
  });

  final mock = await File('test/mocks/accu/conditions/condition.json').readAsString();
  final currentConditionDto = CurrentConditionDto.fromJson(jsonDecode(mock) as Map<String, dynamic>);

  group('Get CurrentCondition by GetCurrentConditionUsecase', () {});
  test(
      'Checks if the GetCurrentConditionUsecase successfully returns a CurrentCondition instance when valid data is provided.',
      () async {
    when(() => datasource.getCurrentCondition(any()))
        .thenAnswer((_) async => CurrentConditionMapper.fromDTO(currentConditionDto));

    final result = await usecase.call('');
    expect(result.isSuccess(), true);
    expect(result.tryGetSuccess(), isA<CurrentCondition>());
    verify(() => datasource.getCurrentCondition(any<String>())).called(1);
    verifyNoMoreInteractions(datasource);
  });
  test(
      'Confirms that an EmptyDataFailure is returned when the WeatherRemoteDatasource finds no data, indicating an empty response.',
      () async {
    when(() => datasource.getCurrentCondition(any())).thenThrow(EmptyDataFailure());
    final result = await usecase.call('');

    expect(result.isError(), true);
    expect(result.tryGetError(), isA<EmptyDataFailure>());
    verify(() => datasource.getCurrentCondition(any())).called(1);
    verifyNoMoreInteractions(datasource);
  });

  test('Ensures that a RequestFailure is returned when the WeatherRemoteDatasource encounters a request error.',
      () async {
    when(() => datasource.getCurrentCondition(any())).thenThrow(RequestFailure());
    final result = await usecase.call('');

    expect(result.isError(), true);
    expect(result.tryGetError(), isA<RequestFailure>());
    verify(() => datasource.getCurrentCondition(any())).called(1);
    verifyNoMoreInteractions(datasource);
  });

  test('Checks if a DtoConversionFailure is thrown when there is a DTO conversion error by the WeatherRemoteDatasource',
      () async {
    when(() => datasource.getCurrentCondition(any())).thenThrow(DtoConversionFailure());
    final result = await usecase.call('');

    expect(result.isError(), true);
    expect(result.tryGetError(), isA<DtoConversionFailure>());
    verify(() => datasource.getCurrentCondition(any())).called(1);
    verifyNoMoreInteractions(datasource);
  });

  test('Confirms that an UnknownFailure is returned for unspecified errors caught by the WeatherRemoteDatasource.',
      () async {
    when(() => datasource.getCurrentCondition(any())).thenThrow(UnknownFailure());
    final result = await usecase.call('');

    expect(result.isError(), true);
    expect(result.tryGetError(), isA<UnknownFailure>());
    verify(() => datasource.getCurrentCondition(any())).called(1);
    verifyNoMoreInteractions(datasource);
  });

  test('Tests if a generic exception is treated as an UnknownFailure by the GetLocationByGeoLocation', () async {
    when(() => datasource.getCurrentCondition(any())).thenThrow(Exception());
    final result = await usecase.call('');

    expect(result.isError(), true);
    expect(result.tryGetError(), isA<UnknownFailure>());
    verify(() => datasource.getCurrentCondition(any())).called(1);
    verifyNoMoreInteractions(datasource);
  });
}
