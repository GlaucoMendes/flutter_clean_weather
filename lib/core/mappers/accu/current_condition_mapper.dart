import '../../../data/dtos/accu/current_condition_dto.dart';
import '../../../domain/entities/current_condition.dart';
import 'icon_mapper.dart';

class CurrentConditionMapper {
  static CurrentCondition fromDTO(CurrentConditionDto dto) {
    return CurrentCondition(
      weatherIcon: IconMapper.codeToIcon(dto.weatherIcon),
      weatherText: dto.weatherText,
      temperature: dto.temperature.imperial.value,
    );
  }
}
