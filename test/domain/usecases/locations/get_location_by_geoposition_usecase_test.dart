import 'dart:convert';
import 'dart:io';

import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/core/mappers/accu/location_mapper.dart';
import 'package:flutter_clean_weather/data/datasources/remote/accu_remote_datasource_impl.dart';
import 'package:flutter_clean_weather/data/dtos/accu/location_dto.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';
import 'package:flutter_clean_weather/domain/usecases/locations/get_location_by_geoposition_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherDatasource extends Mock implements AccuRemoteDatasourceImpl {}

void main() async {
  late AccuRemoteDatasourceImpl datasource;
  late WeatherRepositoryImpl weatherRepository;
  late GetLocationByGeoPositionUsecase usecase;

  final mock = await File('test/mocks/accu/locations/location.json').readAsString();
  final locationDTO = LocationDTO.fromJson(jsonDecode(mock) as Map<String, dynamic>);

  setUp(() {
    datasource = MockWeatherDatasource();
    weatherRepository = WeatherRepositoryImpl(remoteDatasource: datasource);
    usecase = GetLocationByGeoPositionUsecase(repository: weatherRepository);
  });

  group('Get Location by GetLocationByGeoPositionUsecase', () {
    test(
        'Checks if the GetLocationByGeoPositionUsecase successfully returns a Location instance when valid data is provided by the WeatherRemoteDatasource.',
        () async {
      when(() => datasource.getLocationByGeoPosition(any(), any())).thenAnswer(
        (_) async => LocationMapper.fromDTO(locationDTO),
      );
      final result = await usecase.call(0, 0);

      expect(result.isSuccess(), true);
      expect(result.tryGetSuccess(), isA<Location>());
      verify(() => datasource.getLocationByGeoPosition(any(), any())).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test(
        'Confirms that an EmptyDataFailure is returned when the WeatherRemoteDatasource finds no data, indicating an empty response.',
        () async {
      when(() => datasource.getLocationByGeoPosition(any(), any())).thenThrow(EmptyDataFailure());
      final result = await usecase.call(0, 0);

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<EmptyDataFailure>());
      verify(() => datasource.getLocationByGeoPosition(any(), any())).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test('Ensures that a RequestFailure is returned when the WeatherRemoteDatasource encounters a request error.',
        () async {
      when(() => datasource.getLocationByGeoPosition(any(), any())).thenThrow(RequestFailure());
      final result = await usecase.call(0, 0);

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<RequestFailure>());
      verify(() => datasource.getLocationByGeoPosition(any(), any())).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test(
        'Checks if a DtoConversionFailure is thrown when there is a DTO conversion error by the WeatherRemoteDatasource',
        () async {
      when(() => datasource.getLocationByGeoPosition(any(), any())).thenThrow(DtoConversionFailure());
      final result = await usecase.call(0, 0);

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<DtoConversionFailure>());
      verify(() => datasource.getLocationByGeoPosition(any(), any())).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test('Confirms that an UnknownFailure is returned for unspecified errors caught by the WeatherRemoteDatasource.',
        () async {
      when(() => datasource.getLocationByGeoPosition(any(), any())).thenThrow(UnknownFailure());
      final result = await usecase.call(0, 0);

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<UnknownFailure>());
      verify(() => datasource.getLocationByGeoPosition(any(), any())).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test('Tests if a generic exception is treated as an UnknownFailure by the GetLocationByGeoLocation', () async {
      when(() => datasource.getLocationByGeoPosition(any(), any())).thenThrow(Exception());
      final result = await usecase.call(0, 0);

      expect(result.isError(), true);
      expect(result.tryGetError(), isA<UnknownFailure>());
      verify(() => datasource.getLocationByGeoPosition(any(), any())).called(1);
      verifyNoMoreInteractions(datasource);
    });
  });
}
