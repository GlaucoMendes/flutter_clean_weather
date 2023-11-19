import 'package:flutter_clean_weather/data/dtos/current_condition_dto.dart';
import 'package:flutter_clean_weather/domain/entities/current_condition.dart';

class CurrentConditionMapper {
  static CurrentCondition fromDTO(CurrentConditionDto dto) {
    return CurrentCondition();
  }
}
