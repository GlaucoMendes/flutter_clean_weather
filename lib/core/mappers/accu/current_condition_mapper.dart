import 'package:flutter_clean_weather/core/mappers/accu/icon_mapper.dart';
import 'package:flutter_clean_weather/data/dtos/accu/current_condition_dto.dart';
import 'package:flutter_clean_weather/domain/entities/current_condition.dart';

class CurrentConditionMapper {
  static CurrentCondition fromDTO(CurrentConditionDto dto) {
    return CurrentCondition(
      weatherIcon: IconMapper.codeToIcon(dto.weatherIcon),
      weatherText: dto.weatherText,
      temperature: dto.temperature.imperial.value,
    );
  }
}
