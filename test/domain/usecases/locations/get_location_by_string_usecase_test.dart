import 'dart:convert';
import 'dart:io';

import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/datasources/remote/accu_remote_datasource_impl.dart';
import 'package:flutter_clean_weather/data/dtos/accu/location_dto.dart';
import 'package:flutter_clean_weather/data/mappers/accu/location_mapper.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';
import 'package:flutter_clean_weather/domain/usecases/locations/get_location_by_string_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherDatasource extends Mock implements AccuRemoteDatasourceImpl {}

void main() async {
  late AccuRemoteDatasourceImpl weatherRemoteDatasource;
  late WeatherRepositoryImpl weatherRepository;
  late GetLocationByStringUsecase usecase;

  setUp(() {
    weatherRemoteDatasource = MockWeatherDatasource();
    weatherRepository = WeatherRepositoryImpl(remoteDatasource: weatherRemoteDatasource);
    usecase = GetLocationByStringUsecase(repository: weatherRepository);
  });

  final mock = await File('test/mocks/accu/locations/location.json').readAsString();
  final locationDTO = LocationDTO.fromJson(jsonDecode(mock) as Map<String, dynamic>);

  group('Get Location By GetLocationByStringUsecase', () {
    test(
        'Checks if the GetLocationByStringUsecase successfully returns a Location instance when valid data is provided by the WeatherRemoteDatasource.',
        () async {
      when(() => weatherRemoteDatasource.getLocationByString(any())).thenAnswer(
        (_) async => [LocationMapper.fromDTO(locationDTO)],
      );
      final result = await usecase.call('');

      expect(result.isSuccess(), true);
      expect(result.tryGetSuccess(), isA<List<Location>>());
      verify(() => weatherRemoteDatasource.getLocationByString(any())).called(1);
      verifyNoMoreInteractions(weatherRemoteDatasource);
    });

    test(
        'Confirms that an EmptyDataFailure is returned when the WeatherRemoteDatasource finds no data, indicating an empty response.',
        () async {
      when(() => weatherRemoteDatasource.getLocationByString(any())).thenThrow(EmptyDataFailure());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<EmptyDataFailure>());
      verify(() => weatherRemoteDatasource.getLocationByString(any())).called(1);
      verifyNoMoreInteractions(weatherRemoteDatasource);
    });

    test('Ensures that a RequestFailure is returned when the WeatherRemoteDatasource encounters a request error.',
        () async {
      when(() => weatherRemoteDatasource.getLocationByString(any())).thenThrow(RequestFailure());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<RequestFailure>());
      verify(() => weatherRemoteDatasource.getLocationByString(any())).called(1);
      verifyNoMoreInteractions(weatherRemoteDatasource);
    });

    test(
        'Checks if a DtoConversionFailure is thrown when there is a DTO conversion error by the WeatherRemoteDatasource',
        () async {
      when(() => weatherRemoteDatasource.getLocationByString(any())).thenThrow(DtoConversionFailure());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<DtoConversionFailure>());
      verify(() => weatherRemoteDatasource.getLocationByString(any())).called(1);
      verifyNoMoreInteractions(weatherRemoteDatasource);
    });

    test('Confirms that an UnknownFailure is returned for unspecified errors caught by the WeatherRemoteDatasource.',
        () async {
      when(() => weatherRemoteDatasource.getLocationByString(any())).thenThrow(UnknownFailure());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<UnknownFailure>());
      verify(() => weatherRemoteDatasource.getLocationByString(any())).called(1);
      verifyNoMoreInteractions(weatherRemoteDatasource);
    });

    test('Tests if a generic exception is treated as an UnknownFailure by the GetLocationByStringUsecase', () async {
      when(() => weatherRemoteDatasource.getLocationByString(any())).thenThrow(Exception());
      final result = await usecase.call('');

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<UnknownFailure>());
      verify(() => weatherRemoteDatasource.getLocationByString(any())).called(1);
      verifyNoMoreInteractions(weatherRemoteDatasource);
    });
  });
}
