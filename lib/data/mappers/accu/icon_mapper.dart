import '../../../core/enums/weather_icons_enum.dart';

class IconMapper {
  static WeatherIcons? codeToIcon(int code) {
    if ([1].contains(code)) return WeatherIcons.sunny;
    if ([2, 3, 4, 5, 6].contains(code)) return WeatherIcons.partlyCloudy;
    if ([7, 8, 11, 32].contains(code)) return WeatherIcons.windy;
    if ([12, 18, 19].contains(code)) return WeatherIcons.rain;
    if ([13, 14, 20, 21].contains(code)) return WeatherIcons.partlyShower;
    if ([15].contains(code)) return WeatherIcons.storm;
    if ([16, 17].contains(code)) return WeatherIcons.stormShowersDay;
    if ([22, 24, 25, 26, 29].contains(code)) return WeatherIcons.snow;
    if ([23].contains(code)) return WeatherIcons.snowSunny;
    if ([33].contains(code)) return WeatherIcons.night;
    if ([34, 35, 36, 37, 38].contains(code)) return WeatherIcons.cloudyNight;
    if ([39, 40].contains(code)) return WeatherIcons.rainyNight;
    if ([41, 42].contains(code)) return WeatherIcons.thunder;
    if ([43, 44].contains(code)) return WeatherIcons.snowNight;

    return null;
  }
}
