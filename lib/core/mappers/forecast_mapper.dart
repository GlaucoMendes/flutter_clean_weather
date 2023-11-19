import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/core/mappers/icon_mapper.dart';
import 'package:flutter_clean_weather/data/dtos/forecast_dto.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';

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
