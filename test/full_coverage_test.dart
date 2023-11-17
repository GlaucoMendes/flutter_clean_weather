// ignore_for_file: unused_import
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/core/locator.dart';
import 'package:flutter_clean_weather/core/mappers/forecast_mapper.dart';
import 'package:flutter_clean_weather/core/mappers/location_mapper.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource_impl.dart';
import 'package:flutter_clean_weather/data/dtos/forecast_dto.dart';
import 'package:flutter_clean_weather/data/dtos/location_dto.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';
import 'package:flutter_clean_weather/domain/usecases/forecast/get_forecast_by_id_usecase.dart';
import 'package:flutter_clean_weather/domain/usecases/locations/get_location_by_geoposition_usecase.dart';
import 'package:flutter_clean_weather/domain/usecases/locations/get_location_by_string_usecase.dart';
import 'package:flutter_clean_weather/main.dart';

void main() {}
