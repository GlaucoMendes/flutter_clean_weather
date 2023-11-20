// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDTO _$LocationDTOFromJson(Map<String, dynamic> json) => LocationDTO(
      version: json['Version'] as int,
      key: json['Key'] as String,
      type: json['Type'] as String,
      rank: json['Rank'] as int,
      localizedName: json['LocalizedName'] as String,
      englishName: json['EnglishName'] as String,
      primaryPostalCode: json['PrimaryPostalCode'] as String,
      region: CountryDTO.fromJson(json['Region'] as Map<String, dynamic>),
      country: CountryDTO.fromJson(json['Country'] as Map<String, dynamic>),
      administrativeArea: AdministrativeAreaDTO.fromJson(
          json['AdministrativeArea'] as Map<String, dynamic>),
      timeZone: TimeZoneDTO.fromJson(json['TimeZone'] as Map<String, dynamic>),
      geoPosition:
          GeoPositionDTO.fromJson(json['GeoPosition'] as Map<String, dynamic>),
      isAlias: json['IsAlias'] as bool,
      parentCity: json['ParentCity'] == null
          ? null
          : ParentCityDTO.fromJson(json['ParentCity'] as Map<String, dynamic>),
      supplementalAdminAreas: (json['SupplementalAdminAreas'] as List<dynamic>)
          .map((e) =>
              SupplementalAdminAreaDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      dataSets:
          (json['DataSets'] as List<dynamic>).map((e) => e as String).toList(),
    );

AdministrativeAreaDTO _$AdministrativeAreaDTOFromJson(
        Map<String, dynamic> json) =>
    AdministrativeAreaDTO(
      id: json['ID'] as String,
      localizedName: json['LocalizedName'] as String,
      englishName: json['EnglishName'] as String,
      level: json['Level'] as int,
      localizedType: json['LocalizedType'] as String,
      englishType: json['EnglishType'] as String,
      countryId: json['CountryID'] as String,
    );

CountryDTO _$CountryDTOFromJson(Map<String, dynamic> json) => CountryDTO(
      id: json['ID'] as String,
      localizedName: json['LocalizedName'] as String,
      englishName: json['EnglishName'] as String,
    );

GeoPositionDTO _$GeoPositionDTOFromJson(Map<String, dynamic> json) =>
    GeoPositionDTO(
      latitude: (json['Latitude'] as num).toDouble(),
      longitude: (json['Longitude'] as num).toDouble(),
      elevation:
          ElevationDTO.fromJson(json['Elevation'] as Map<String, dynamic>),
    );

ElevationDTO _$ElevationDTOFromJson(Map<String, dynamic> json) => ElevationDTO(
      metric: ImperialDTO.fromJson(json['Metric'] as Map<String, dynamic>),
      imperial: ImperialDTO.fromJson(json['Imperial'] as Map<String, dynamic>),
    );

ImperialDTO _$ImperialDTOFromJson(Map<String, dynamic> json) => ImperialDTO(
      value: (json['Value'] as num).toDouble(),
      unit: json['Unit'] as String,
      unitType: json['UnitType'] as int,
    );

ParentCityDTO _$ParentCityDTOFromJson(Map<String, dynamic> json) =>
    ParentCityDTO(
      key: json['Key'] as String,
      localizedName: json['LocalizedName'] as String,
      englishName: json['EnglishName'] as String,
    );

SupplementalAdminAreaDTO _$SupplementalAdminAreaDTOFromJson(
        Map<String, dynamic> json) =>
    SupplementalAdminAreaDTO(
      level: json['Level'] as int,
      localizedName: json['LocalizedName'] as String,
      englishName: json['EnglishName'] as String,
    );

TimeZoneDTO _$TimeZoneDTOFromJson(Map<String, dynamic> json) => TimeZoneDTO(
      code: json['Code'] as String,
      name: json['Name'] as String,
      gmtOffset: (json['GmtOffset'] as num).toDouble(),
      isDaylightSaving: json['IsDaylightSaving'] as bool,
      nextOffsetChange: json['NextOffsetChange'],
    );
