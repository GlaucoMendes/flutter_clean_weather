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
      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data.isNotEmpty) {
          final first = data.first;
          if (first is! Map<String, dynamic>) throw DtoConversionFailure();

          return LocationMapper.fromDTO(LocationDTO.fromJson(first));
        } else {
          throw EmptyDataFailure();
        }
      } else {
        throw RequestFailure(statusCode: response.statusCode);
      }
    } catch (e) {
      throw UnknownFailure(message: e.toString());
    }
  }
}
