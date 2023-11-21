import 'package:flutter_clean_weather/core/core.dart';
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
              assetIconDay: 'assets/wapi_icons/day/${_getCode(e.day.condition.icon)}',
              assetIconNight: 'assets/wapi_icons/night/${_getCode(e.day.condition.icon)}',
            ),
          )
          .toList(),
    );
  }

  static String _getCode(String url) {
    final split = url.split('/');
    return split[split.length - 1];
  }
}
