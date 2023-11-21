import 'package:flutter_clean_weather/core/enums/weather_icons_enum.dart';
import 'package:flutter_clean_weather/data/dtos/wapi/current_condition_dto.dart';
import 'package:flutter_clean_weather/domain/entities/current_condition.dart';

class CurrentConditionMapper {
  static CurrentCondition fromDTO(CurrentConditionDTO dto) {
    return CurrentCondition(
      weatherIcon: WeatherIcons.cloudyNight,
      weatherText: dto.condition.text,
      temperature: dto.tempF,
    );
  }
}
