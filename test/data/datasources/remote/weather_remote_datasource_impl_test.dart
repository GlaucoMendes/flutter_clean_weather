import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource_impl.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() async {
  late WeatherRemoteDatasourceImpl weatherRemoteDatasourceImpl;
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    weatherRemoteDatasourceImpl = WeatherRemoteDatasourceImpl(dio: dio);
  });

  final data = jsonDecode(await File('test/mocks/locations/location.json').readAsString());
  const path = '/locations/v1/search';

  group('Weather Remote Datasource', () {
    test(
        'Verifies if the getLocationByString method returns a Location instance when valid data is received from the API.',
        () async {
      dioAdapter.onGet(path, (server) => server.reply(200, [data]));
      final result = await weatherRemoteDatasourceImpl.getLocationByString('');
      expect(result, isA<Location>());
    });

    test(
        'Confirms that an EmptyDataFailure is thrown when the API returns an empty list, indicating no data was found.',
        () async {
      dioAdapter.onGet(path, (server) => server.reply(200, <dynamic>[]));
      final call = weatherRemoteDatasourceImpl.getLocationByString('');

      await expectLater(call, throwsA(isA<EmptyDataFailure>()));
    });

    test(
        'Ensures that a RequestFailure is thrown when the API returns an error status (e.g., 400), indicating a request failure.',
        () async {
      dioAdapter.onGet(path, (server) => server.reply(400, ''));
      final call = weatherRemoteDatasourceImpl.getLocationByString('');

      await expectLater(call, throwsA(isA<RequestFailure>()));
    });

    test('Test for DtoConversionFailure Return for Invalid Response', () async {
      dioAdapter.onGet(path, (server) => server.reply(200, ['']));
      final call = weatherRemoteDatasourceImpl.getLocationByString('');

      await expectLater(call, throwsA(isA<DtoConversionFailure>()));
    });

    test('Test for DtoConversionFailure Return for Invalid JSON', () async {
      dioAdapter.onGet(
        path,
        (server) => server.reply(200, [
          <String, dynamic>{'InvalidKey': 'InvalidValue'},
        ]),
      );
      final call = weatherRemoteDatasourceImpl.getLocationByString('');

      await expectLater(call, throwsA(isA<DtoConversionFailure>()));
    });
  });
}
