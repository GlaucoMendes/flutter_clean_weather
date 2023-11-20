import 'package:json_annotation/json_annotation.dart';

part 'forecast_dto.g.dart';

@JsonSerializable(createToJson: false)
class ForecastDTO {
  @JsonKey(name: 'Headline')
  final HeadlineDTO headline;
  @JsonKey(name: 'DailyForecasts')
  final List<DailyForecastDTO> dailyForecasts;

  ForecastDTO({
    required this.headline,
    required this.dailyForecasts,
  });

  factory ForecastDTO.fromJson(Map<String, dynamic> json) => _$ForecastDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class DailyForecastDTO {
  @JsonKey(name: 'Date')
  final String date;
  @JsonKey(name: 'EpochDate')
  final int epochDate;
  @JsonKey(name: 'Temperature')
  final TemperatureDTO temperature;
  @JsonKey(name: 'Day')
  final DayDTO day;
  @JsonKey(name: 'Night')
  final DayDTO night;
  @JsonKey(name: 'Sources')
  final List<String> sources;
  @JsonKey(name: 'MobileLink')
  final String mobileLink;
  @JsonKey(name: 'Link')
  final String link;

  DailyForecastDTO({
    required this.date,
    required this.epochDate,
    required this.temperature,
    required this.day,
    required this.night,
    required this.sources,
    required this.mobileLink,
    required this.link,
  });

  factory DailyForecastDTO.fromJson(Map<String, dynamic> json) => _$DailyForecastDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class DayDTO {
  @JsonKey(name: 'Icon')
  final int icon;
  @JsonKey(name: 'IconPhrase')
  final String iconPhrase;
  @JsonKey(name: 'HasPrecipitation')
  final bool hasPrecipitation;
  @JsonKey(name: 'PrecipitationType')
  final String? precipitationType;
  @JsonKey(name: 'PrecipitationIntensity')
  final String? precipitationIntensity;

  DayDTO({
    required this.icon,
    required this.iconPhrase,
    required this.hasPrecipitation,
    this.precipitationType,
    this.precipitationIntensity,
  });

  factory DayDTO.fromJson(Map<String, dynamic> json) => _$DayDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class TemperatureDTO {
  @JsonKey(name: 'Minimum')
  final ImumDTO minimum;
  @JsonKey(name: 'Maximum')
  final ImumDTO maximum;

  TemperatureDTO({
    required this.minimum,
    required this.maximum,
  });

  factory TemperatureDTO.fromJson(Map<String, dynamic> json) => _$TemperatureDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class ImumDTO {
  @JsonKey(name: 'Value')
  final double value;
  @JsonKey(name: 'Unit')
  final String unit;
  @JsonKey(name: 'UnitType')
  final int unitType;

  ImumDTO({
    required this.value,
    required this.unit,
    required this.unitType,
  });

  factory ImumDTO.fromJson(Map<String, dynamic> json) => _$ImumDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class HeadlineDTO {
  @JsonKey(name: 'EffectiveDate')
  final String effectiveDate;
  @JsonKey(name: 'EffectiveEpochDate')
  final int effectiveEpochDate;
  @JsonKey(name: 'Severity')
  final int severity;
  @JsonKey(name: 'Text')
  final String text;
  @JsonKey(name: 'Category')
  final String category;
  @JsonKey(name: 'EndDate')
  final String endDate;
  @JsonKey(name: 'EndEpochDate')
  final int endEpochDate;
  @JsonKey(name: 'MobileLink')
  final String mobileLink;
  @JsonKey(name: 'Link')
  final String link;

  HeadlineDTO({
    required this.effectiveDate,
    required this.effectiveEpochDate,
    required this.severity,
    required this.text,
    required this.category,
    required this.endDate,
    required this.endEpochDate,
    required this.mobileLink,
    required this.link,
  });

  factory HeadlineDTO.fromJson(Map<String, dynamic> json) => _$HeadlineDTOFromJson(json);
}
