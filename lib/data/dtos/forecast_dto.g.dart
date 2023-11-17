// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastDTO _$ForecastDTOFromJson(Map<String, dynamic> json) => ForecastDTO(
      headline: HeadlineDTO.fromJson(json['Headline'] as Map<String, dynamic>),
      dailyForecasts: (json['DailyForecasts'] as List<dynamic>)
          .map((e) => DailyForecastDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DailyForecastDTO _$DailyForecastDTOFromJson(Map<String, dynamic> json) =>
    DailyForecastDTO(
      date: json['Date'] as String,
      epochDate: json['EpochDate'] as int,
      temperature:
          TemperatureDTO.fromJson(json['Temperature'] as Map<String, dynamic>),
      day: DayDTO.fromJson(json['Day'] as Map<String, dynamic>),
      night: DayDTO.fromJson(json['Night'] as Map<String, dynamic>),
      sources:
          (json['Sources'] as List<dynamic>).map((e) => e as String).toList(),
      mobileLink: json['MobileLink'] as String,
      link: json['Link'] as String,
    );

DayDTO _$DayDTOFromJson(Map<String, dynamic> json) => DayDTO(
      icon: json['Icon'] as int,
      iconPhrase: json['IconPhrase'] as String,
      hasPrecipitation: json['HasPrecipitation'] as bool,
      precipitationType: json['PrecipitationType'] as String?,
      precipitationIntensity: json['PrecipitationIntensity'] as String?,
    );

TemperatureDTO _$TemperatureDTOFromJson(Map<String, dynamic> json) =>
    TemperatureDTO(
      minimum: ImumDTO.fromJson(json['Minimum'] as Map<String, dynamic>),
      maximum: ImumDTO.fromJson(json['Maximum'] as Map<String, dynamic>),
    );

ImumDTO _$ImumDTOFromJson(Map<String, dynamic> json) => ImumDTO(
      value: (json['Value'] as num).toDouble(),
      unit: json['Unit'] as String,
      unitType: json['UnitType'] as int,
    );

HeadlineDTO _$HeadlineDTOFromJson(Map<String, dynamic> json) => HeadlineDTO(
      effectiveDate: json['EffectiveDate'] as String,
      effectiveEpochDate: json['EffectiveEpochDate'] as int,
      severity: json['Severity'] as int,
      text: json['Text'] as String,
      category: json['Category'] as String,
      endDate: json['EndDate'] as String,
      endEpochDate: json['EndEpochDate'] as int,
      mobileLink: json['MobileLink'] as String,
      link: json['Link'] as String,
    );
