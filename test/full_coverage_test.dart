// ignore_for_file: unused_import
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/core/enums/weather_icons_enum.dart';
import 'package:flutter_clean_weather/core/extensions/double_extension.dart';
import 'package:flutter_clean_weather/core/locator.dart';
import 'package:flutter_clean_weather/core/mappers/current_condition_mapper.dart';
import 'package:flutter_clean_weather/core/mappers/forecast_mapper.dart';
import 'package:flutter_clean_weather/core/mappers/icon_mapper.dart';
import 'package:flutter_clean_weather/core/mappers/location_mapper.dart';
import 'package:flutter_clean_weather/core/services/geoposition_service.dart';
import 'package:flutter_clean_weather/core/services/permission_service.dart';
import 'package:flutter_clean_weather/core/theme/weather_theme_data.dart';
import 'package:flutter_clean_weather/core/utils/snacks.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:flutter_clean_weather/data/datasources/remote/weather_remote_datasource_impl.dart';
import 'package:flutter_clean_weather/data/dtos/current_condition_dto.dart';
import 'package:flutter_clean_weather/data/dtos/forecast_dto.dart';
import 'package:flutter_clean_weather/data/dtos/location_dto.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository.dart';
import 'package:flutter_clean_weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_weather/domain/entities/current_condition.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';
import 'package:flutter_clean_weather/domain/usecases/conditions/get_current_condition_usecase.dart';
import 'package:flutter_clean_weather/domain/usecases/forecast/get_forecast_by_id_usecase.dart';
import 'package:flutter_clean_weather/domain/usecases/locations/get_location_by_geoposition_usecase.dart';
import 'package:flutter_clean_weather/domain/usecases/locations/get_location_by_string_usecase.dart';
import 'package:flutter_clean_weather/main.dart';
import 'package:flutter_clean_weather/presentation/home/cubits/condition/current_condition_cubit.dart';
import 'package:flutter_clean_weather/presentation/home/cubits/forecast/forecast_cubit.dart';
import 'package:flutter_clean_weather/presentation/home/home_screen.dart';
import 'package:flutter_clean_weather/presentation/home/widgets/current_condition_widget.dart';
import 'package:flutter_clean_weather/presentation/home/widgets/forecast_widget.dart';
import 'package:flutter_clean_weather/presentation/onboarding/onboarding_screen.dart';
import 'package:flutter_clean_weather/presentation/onboarding/pages/search_location_page.dart';
import 'package:flutter_clean_weather/presentation/onboarding/widgets/location_button_widget.dart';

void main() {}
