// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_condition_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentConditionDto _$CurrentConditionDtoFromJson(Map<String, dynamic> json) =>
    CurrentConditionDto(
      localObservationDateTime: json['LocalObservationDateTime'] as String,
      epochTime: json['EpochTime'] as int,
      weatherText: json['WeatherText'] as String,
      weatherIcon: json['WeatherIcon'] as int,
      hasPrecipitation: json['HasPrecipitation'] as bool,
      precipitationType: json['PrecipitationType'],
      isDayTime: json['IsDayTime'] as bool,
      temperature:
          Temperature.fromJson(json['Temperature'] as Map<String, dynamic>),
      mobileLink: json['MobileLink'] as String,
      link: json['Link'] as String,
    );

Temperature _$TemperatureFromJson(Map<String, dynamic> json) => Temperature(
      metric: Metric.fromJson(json['Metric'] as Map<String, dynamic>),
      imperial: Imperial.fromJson(json['Imperial'] as Map<String, dynamic>),
    );

Imperial _$ImperialFromJson(Map<String, dynamic> json) => Imperial(
      value: (json['Value'] as num).toDouble(),
      unit: json['Unit'] as String,
      unitType: json['UnitType'] as int,
    );

Metric _$MetricFromJson(Map<String, dynamic> json) => Metric(
      value: (json['Value'] as num).toDouble(),
      unit: json['Unit'] as String,
      unitType: json['UnitType'] as int,
    );
