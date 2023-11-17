import 'package:dio/dio.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/core/mappers/forecast_mapper.dart';
import 'package:flutter_clean_weather/core/mappers/location_mapper.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:flutter_clean_weather/data/dtos/forecast_dto.dart';
import 'package:flutter_clean_weather/data/dtos/location_dto.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

class WeatherRemoteDatasourceImpl implements WeatherRemoteDatasource {
  final Dio dio;
  WeatherRemoteDatasourceImpl({required this.dio});

  @override
  Future<Location> getLocationByString(String text) async {
    try {
      final response = await dio.get<List<dynamic>>('/locations/v1/search', queryParameters: {'q': text});

      final data = response.data;
      if (data != null && data.isNotEmpty) {
        final first = data.first;
        if (first is! Map<String, dynamic>) throw DtoConversionFailure();
        final dto = safeFromJson<LocationDTO>(first, LocationDTO.fromJson);

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
}
