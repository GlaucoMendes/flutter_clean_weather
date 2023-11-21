import 'package:dio/dio.dart';

import '../../../core/core.dart';
import '../../../core/mappers/wapi/current_condition_mapper.dart';
import '../../../core/mappers/wapi/forecast_mapper.dart';
import '../../../core/mappers/wapi/location_mapper.dart';
import '../../../domain/entities/current_condition.dart';
import '../../../domain/entities/forecast.dart';
import '../../../domain/entities/location.dart';
import '../../dtos/wapi/current_condition_dto.dart';
import '../../dtos/wapi/forecast_dto.dart' as forecast;
import '../../dtos/wapi/location_dto.dart';
import 'weather_remote_datasource.dart';

class WapiRemoteDatasourceImpl implements WeatherRemoteDatasource {
  final Dio dio;
  WapiRemoteDatasourceImpl({required this.dio});

  @override
  Future<CurrentCondition> getCurrentCondition(String id) async {
    try {
      final response = await dio.get<dynamic>('/current.json', queryParameters: {'q': 'id:$id'});
      final data = response.data;

      if (data != null) {
        if (data is! Map<String, dynamic>) throw DtoConversionFailure();

        if (data.containsKey('current')) {
          final dto =
              safeFromJson<CurrentConditionDTO>(data['current'] as Map<String, dynamic>, CurrentConditionDTO.fromJson);

          return CurrentConditionMapper.fromDTO(dto);
        } else {
          throw DtoConversionFailure();
        }
      } else {
        throw EmptyDataFailure();
      }
    } on DioException catch (e) {
      throw RequestFailure(statusCode: e.response?.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Forecast> getForecastById(String id) async {
    try {
      final response = await dio.get<dynamic>(
        '/forecast.json',
        queryParameters: {
          'q': 'id:$id',
          'days': 5,
          'aqi': 'no',
          'alerts': 'no',
        },
      );

      final data = response.data;
      if (data != null) {
        if (data is! Map<String, dynamic>) throw DtoConversionFailure();

        final dto = safeFromJson<forecast.ForecastAPI>(data, forecast.ForecastAPI.fromJson);

        return ForecastMapper.fromDTO(dto.forecast);
      } else {
        throw EmptyDataFailure();
      }
    } on DioException catch (e) {
      throw RequestFailure(statusCode: e.response?.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Location> getLocationByGeoPosition(double lat, double long) async {
    try {
      final result = await _getLocation('$lat,$long');

      return result.first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Location>> getLocationByString(String text) {
    try {
      return _getLocation(text);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Location>> _getLocation(String text) async {
    try {
      final response = await dio.get<List<dynamic>>('/search.json', queryParameters: {'q': text});

      final data = response.data;
      if (data != null && data.isNotEmpty) {
        final result =
            data.map((e) => safeFromJson<LocationDTO>(e as Map<String, dynamic>, LocationDTO.fromJson)).toList();
        return result.map(LocationMapper.fromDTO).toList();
      } else {
        throw EmptyDataFailure();
      }
    } on DioException catch (e) {
      throw RequestFailure(statusCode: e.response?.statusCode);
    } catch (e) {
      rethrow;
    }
  }
}
