import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/datasources/remote/accu_remote_datasource_impl.dart';
import 'package:flutter_clean_weather/domain/entities/current_condition.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() async {
  late AccuRemoteDatasourceImpl datasource;
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    datasource = AccuRemoteDatasourceImpl(dio: dio);
  });

  final locationMock = jsonDecode(await File('test/mocks/accu/locations/location.json').readAsString());
  final forecastMock = jsonDecode(await File('test/mocks/accu/forecasts/forecast.json').readAsString());
  final currentConditionMock = jsonDecode(await File('test/mocks/accu/conditions/condition.json').readAsString());
  const namePath = '/locations/v1/search';
  const geoPath = '/locations/v1/cities/geoposition/search';
  const forecastPath = '/forecasts/v1/daily/5day/';
  const currentConditionPath = '/currentconditions/v1/';

  group('GetLocationByString', () {
    test(
        'Verifies if the getLocationByString method returns a Location instance when valid data is received from the API.',
        () async {
      dioAdapter.onGet(namePath, (server) => server.reply(200, [locationMock]));
      final result = await datasource.getLocationByString('');
      expect(result, isA<List<Location>>());
    });

    test(
        'Confirms that an EmptyDataFailure is thrown when the API returns an empty list, indicating no data was found.',
        () async {
      dioAdapter.onGet(namePath, (server) => server.reply(200, <dynamic>[]));
      final call = datasource.getLocationByString('');

      await expectLater(call, throwsA(isA<EmptyDataFailure>()));
    });

    test(
        'Ensures that a RequestFailure is thrown when the API returns an error status (e.g., 400), indicating a request failure.',
        () async {
      dioAdapter.onGet(namePath, (server) => server.reply(400, ''));
      final call = datasource.getLocationByString('');

      await expectLater(call, throwsA(isA<RequestFailure>()));
    });

    test('Test for DtoConversionFailure Return for Invalid JSON', () async {
      dioAdapter.onGet(
        namePath,
        (server) => server.reply(200, [
          <String, dynamic>{'InvalidKey': 'InvalidValue'},
        ]),
      );
      final call = datasource.getLocationByString('');

      await expectLater(call, throwsA(isA<DtoConversionFailure>()));
    });
  });
  group('GetLocationByGeoLocation', () {
    test(
        'Verifies if the getLocationByGeoLocation method returns a Location instance when valid data is received from the API.',
        () async {
      dioAdapter.onGet(geoPath, (server) => server.reply(200, locationMock));
      final result = await datasource.getLocationByGeoPosition(0, 0);
      expect(result, isA<Location>());
    });

    test(
        'Confirms that an EmptyDataFailure is thrown when the API returns an empty list, indicating no data was found.',
        () async {
      dioAdapter.onGet(geoPath, (server) => server.reply(200, null));
      final call = datasource.getLocationByGeoPosition(0, 0);

      await expectLater(call, throwsA(isA<EmptyDataFailure>()));
    });

    test(
        'Ensures that a RequestFailure is thrown when the API returns an error status (e.g., 400), indicating a request failure.',
        () async {
      dioAdapter.onGet(geoPath, (server) => server.reply(400, ''));
      final call = datasource.getLocationByGeoPosition(0, 0);

      await expectLater(call, throwsA(isA<RequestFailure>()));
    });

    test('Test for DtoConversionFailure Return for Invalid Response', () async {
      dioAdapter.onGet(geoPath, (server) => server.reply(200, ['']));
      final call = datasource.getLocationByGeoPosition(0, 0);

      await expectLater(call, throwsA(isA<DtoConversionFailure>()));
    });
  });
  group('GetForecastById', () {
    test('Verifies if the getForecastById method returns a Forecast instance when valid data is received from the API.',
        () async {
      dioAdapter.onGet(forecastPath, (server) => server.reply(200, forecastMock));
      final result = await datasource.getForecastById('');
      expect(result, isA<Forecast>());
    });

    test(
        'Confirms that an EmptyDataFailure is thrown when the API returns an empty list, indicating no data was found.',
        () async {
      dioAdapter.onGet(forecastPath, (server) => server.reply(200, null));
      final call = datasource.getForecastById('');

      await expectLater(call, throwsA(isA<EmptyDataFailure>()));
    });

    test(
        'Ensures that a RequestFailure is thrown when the API returns an error status (e.g., 400), indicating a request failure.',
        () async {
      dioAdapter.onGet(forecastPath, (server) => server.reply(400, ''));
      final call = datasource.getForecastById('');

      await expectLater(call, throwsA(isA<RequestFailure>()));
    });

    test('Test for DtoConversionFailure Return for Invalid Response', () async {
      dioAdapter.onGet(forecastPath, (server) => server.reply(200, ['']));
      final call = datasource.getForecastById('');

      await expectLater(call, throwsA(isA<DtoConversionFailure>()));
    });
  });
  group('GetCurrentCondition', () {
    test(
        'Verifies if the getCurrentCondition method returns a CurrentCondition instance when valid data is received from the API.',
        () async {
      dioAdapter.onGet(currentConditionPath, (server) => server.reply(200, [currentConditionMock]));
      final result = await datasource.getCurrentCondition('');
      expect(result, isA<CurrentCondition>());
    });

    test(
        'Confirms that an EmptyDataFailure is thrown when the API returns an empty list, indicating no data was found.',
        () async {
      dioAdapter.onGet(currentConditionPath, (server) => server.reply(200, null));
      final call = datasource.getCurrentCondition('');

      await expectLater(call, throwsA(isA<EmptyDataFailure>()));
    });

    test(
        'Ensures that a RequestFailure is thrown when the API returns an error status (e.g., 400), indicating a request failure.',
        () async {
      dioAdapter.onGet(currentConditionPath, (server) => server.reply(400, ''));
      final call = datasource.getCurrentCondition('');

      await expectLater(call, throwsA(isA<RequestFailure>()));
    });

    test('Test for DtoConversionFailure Return for Invalid Response', () async {
      dioAdapter.onGet(currentConditionPath, (server) => server.reply(200, ['']));
      final call = datasource.getCurrentCondition('');

      await expectLater(call, throwsA(isA<DtoConversionFailure>()));
    });
  });
}
