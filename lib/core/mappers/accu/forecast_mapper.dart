import '../../../data/dtos/accu/forecast_dto.dart';
import '../../../domain/entities/forecast.dart';
import '../../core.dart';
import 'icon_mapper.dart';

class ForecastMapper {
  static Forecast fromDTO(ForecastDTO dto) {
    return Forecast(
      dailyForecasts: dto.dailyForecasts.map((e) {
        return DailyForecast(
          date: DateTime.parse(e.date).toTimeZone,
          minTemp: e.temperature.minimum.value,
          maxTemp: e.temperature.maximum.value,
          iconDay: IconMapper.codeToIcon(e.day.icon),
          iconNight: IconMapper.codeToIcon(e.night.icon),
        );
      }).toList(),
    );
  }
}
