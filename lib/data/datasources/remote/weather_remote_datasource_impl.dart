import 'package:dio/dio.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/core/mappers/location_mapper.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:flutter_clean_weather/data/dtos/location_dto.dart';
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
    } on DtoConversionFailure {
      rethrow;
    } on EmptyDataFailure {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
