import '../../../data/dtos/wapi/current_condition_dto.dart';
import '../../../domain/entities/current_condition.dart';

class CurrentConditionMapper {
  static CurrentCondition fromDTO(CurrentConditionDTO dto) {
    return CurrentCondition(
      assetIcon: dto.isDay == 1
          ? 'assets/wapi_icons/day/${_getCode(dto.condition.icon)}'
          : 'assets/wapi_icons/night/${_getCode(dto.condition.icon)}',
      weatherText: dto.condition.text,
      temperature: dto.tempF,
    );
  }

  static String _getCode(String url) {
    final split = url.split('/');
    return split[split.length - 1];
  }
}
