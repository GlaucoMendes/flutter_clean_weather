import 'package:json_annotation/json_annotation.dart';

part 'current_condition_dto.g.dart';

@JsonSerializable(createToJson: false)
class CurrentConditionDto {
  @JsonKey(name: 'LocalObservationDateTime')
  final String localObservationDateTime;
  @JsonKey(name: 'EpochTime')
  final int epochTime;
  @JsonKey(name: 'WeatherText')
  final String weatherText;
  @JsonKey(name: 'WeatherIcon')
  final int weatherIcon;
  @JsonKey(name: 'HasPrecipitation')
  final bool hasPrecipitation;
  @JsonKey(name: 'PrecipitationType')
  final dynamic precipitationType;
  @JsonKey(name: 'IsDayTime')
  final bool isDayTime;
  @JsonKey(name: 'Temperature')
  final Temperature temperature;
  @JsonKey(name: 'MobileLink')
  final String mobileLink;
  @JsonKey(name: 'Link')
  final String link;

  CurrentConditionDto({
    required this.localObservationDateTime,
    required this.epochTime,
    required this.weatherText,
    required this.weatherIcon,
    required this.hasPrecipitation,
    required this.precipitationType,
    required this.isDayTime,
    required this.temperature,
    required this.mobileLink,
    required this.link,
  });

  factory CurrentConditionDto.fromJson(Map<String, dynamic> json) => _$CurrentConditionDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class Temperature {
  @JsonKey(name: 'Metric')
  final Metric metric;
  @JsonKey(name: 'Imperial')
  final Imperial imperial;

  Temperature({
    required this.metric,
    required this.imperial,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) => _$TemperatureFromJson(json);
}

@JsonSerializable(createToJson: false)
class Imperial {
  @JsonKey(name: 'Value')
  final double value;
  @JsonKey(name: 'Unit')
  final String unit;
  @JsonKey(name: 'UnitType')
  final int unitType;

  Imperial({
    required this.value,
    required this.unit,
    required this.unitType,
  });

  factory Imperial.fromJson(Map<String, dynamic> json) => _$ImperialFromJson(json);
}

@JsonSerializable(createToJson: false)
class Metric {
  @JsonKey(name: 'Value')
  final double value;
  @JsonKey(name: 'Unit')
  final String unit;
  @JsonKey(name: 'UnitType')
  final int unitType;

  Metric({
    required this.value,
    required this.unit,
    required this.unitType,
  });

  factory Metric.fromJson(Map<String, dynamic> json) => _$MetricFromJson(json);
}
