import 'dart:convert';
import 'dart:io';

import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/core/locator.dart';
import 'package:flutter_clean_weather/core/mappers/location_mapper.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource_impl.dart';
import 'package:flutter_clean_weather/data/dtos/location_dto.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';
import 'package:flutter_clean_weather/domain/usecases/locations/get_location_by_string_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherDatasource extends Mock implements WeatherRemoteDatasourceImpl {}

void main() async {
  Locator.init();
  late WeatherRemoteDatasourceImpl weatherRemoteDatasource;
  late WeatherRepositoryImpl weatherRepository;
  late GetLocationByStringUsecase usecase;

  setUp(() {
    weatherRemoteDatasource = MockWeatherDatasource();
    weatherRepository = WeatherRepositoryImpl(remoteDatasource: weatherRemoteDatasource);
    usecase = GetLocationByStringUsecase(repository: weatherRepository);
  });

  final mock = await File('test/mocks/locations/location.json').readAsString();
  final locationDTO = LocationDTO.fromJson(jsonDecode(mock) as Map<String, dynamic>);
  group('GetLocationByStringUsecase', () {
    test('should return a location by city name', () async {
      when(() => weatherRemoteDatasource.getLocationByString(any())).thenAnswer(
        (_) async => LocationMapper.fromDTO(locationDTO),
      );
      final result = await usecase.call('');

      expect(result.isSuccess(), true);
      expect(result.tryGetSuccess(), isA<Location>());
      verify(() => weatherRemoteDatasource.getLocationByString(any())).called(1);
      verifyNoMoreInteractions(weatherRemoteDatasource);
    });

    test('should return a EmptyDataFailure', () async {
      when(() => weatherRemoteDatasource.getLocationByString(any())).thenThrow(EmptyDataFailure());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<EmptyDataFailure>());
      verify(() => weatherRemoteDatasource.getLocationByString(any())).called(1);
      verifyNoMoreInteractions(weatherRemoteDatasource);
    });

    test('should return a RequestFailure', () async {
      when(() => weatherRemoteDatasource.getLocationByString(any())).thenThrow(RequestFailure());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<RequestFailure>());
      verify(() => weatherRemoteDatasource.getLocationByString(any())).called(1);
      verifyNoMoreInteractions(weatherRemoteDatasource);
    });

    test('should return a DtoConversionFailure', () async {
      when(() => weatherRemoteDatasource.getLocationByString(any())).thenThrow(DtoConversionFailure());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<DtoConversionFailure>());
      verify(() => weatherRemoteDatasource.getLocationByString(any())).called(1);
      verifyNoMoreInteractions(weatherRemoteDatasource);
    });

    test('should return a UnknownFailure', () async {
      when(() => weatherRemoteDatasource.getLocationByString(any())).thenThrow(UnknownFailure());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<UnknownFailure>());
      verify(() => weatherRemoteDatasource.getLocationByString(any())).called(1);
      verifyNoMoreInteractions(weatherRemoteDatasource);
    });

    test('should return a Exception', () async {
      when(() => weatherRemoteDatasource.getLocationByString(any())).thenThrow(Exception());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<UnknownFailure>());
      verify(() => weatherRemoteDatasource.getLocationByString(any())).called(1);
      verifyNoMoreInteractions(weatherRemoteDatasource);
    });
  });
}
