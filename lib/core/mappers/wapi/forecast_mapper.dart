import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/core/enums/weather_icons_enum.dart';
import 'package:flutter_clean_weather/data/dtos/wapi/forecast_dto.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';

class ForecastMapper {
  static Forecast fromDTO(ForecastDTO dto) {
    return Forecast(
      dailyForecasts: dto.forecastday
          .map(
            (e) => DailyForecast(
              date: e.date.toTimeZone,
              minTemp: e.day.mintempF,
              maxTemp: e.day.maxtempF,
              iconDay: WeatherIcons.cloudyNight,
              iconNight: WeatherIcons.cloudyNight,
            ),
          )
          .toList(),
    );
  }
}
