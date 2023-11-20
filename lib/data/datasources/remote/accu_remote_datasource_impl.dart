import 'package:dio/dio.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/core/mappers/accu/current_condition_mapper.dart';
import 'package:flutter_clean_weather/core/mappers/accu/forecast_mapper.dart';
import 'package:flutter_clean_weather/core/mappers/accu/location_mapper.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:flutter_clean_weather/data/dtos/accu/current_condition_dto.dart';
import 'package:flutter_clean_weather/data/dtos/accu/forecast_dto.dart';
import 'package:flutter_clean_weather/data/dtos/accu/location_dto.dart';
import 'package:flutter_clean_weather/domain/entities/current_condition.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

class AccuRemoteDatasourceImpl implements WeatherRemoteDatasource {
  final Dio dio;
  AccuRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<Location>> getLocationByString(String text) async {
    try {
      final response = await dio.get<List<dynamic>>('/locations/v1/search', queryParameters: {'q': text});

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

  @override
  Future<Location> getLocationByGeoPosition(double lat, double long) async {
    try {
      final response =
          await dio.get<dynamic>('/locations/v1/cities/geoposition/search', queryParameters: {'q': '$lat,$long'});

      final data = response.data;
      if (data != null) {
        if (data is! Map<String, dynamic>) throw DtoConversionFailure();
        final dto = safeFromJson<LocationDTO>(data, LocationDTO.fromJson);

        return LocationMapper.fromDTO(dto);
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
      final response = await dio.get<dynamic>('/forecasts/v1/daily/5day/$id');

      final data = response.data;
      if (data != null) {
        if (data is! Map<String, dynamic>) throw DtoConversionFailure();
        final dto = safeFromJson<ForecastDTO>(data, ForecastDTO.fromJson);

        return ForecastMapper.fromDTO(dto);
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
  Future<CurrentCondition> getCurrentCondition(String id) async {
    try {
      final response = await dio.get<List<dynamic>>('/currentconditions/v1/$id');

      final data = response.data;
      if (data != null && data.isNotEmpty) {
        final first = data.first;
        if (first is! Map<String, dynamic>) throw DtoConversionFailure();
        final dto = safeFromJson<CurrentConditionDto>(first, CurrentConditionDto.fromJson);

        return CurrentConditionMapper.fromDTO(dto);
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
