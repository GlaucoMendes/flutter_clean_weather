import 'package:json_annotation/json_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, createToJson: false)
class LocationDTO {
  final int version;
  final String key;
  final String type;
  final int rank;
  final String localizedName;
  final String englishName;
  final String primaryPostalCode;
  final CountryDTO region;
  final CountryDTO country;
  final AdministrativeAreaDTO administrativeArea;
  final TimeZoneDTO timeZone;
  final GeoPositionDTO geoPosition;
  final bool isAlias;
  final ParentCityDTO? parentCity;
  final List<SupplementalAdminAreaDTO> supplementalAdminAreas;
  final List<String> dataSets;

  LocationDTO({
    required this.version,
    required this.key,
    required this.type,
    required this.rank,
    required this.localizedName,
    required this.englishName,
    required this.primaryPostalCode,
    required this.region,
    required this.country,
    required this.administrativeArea,
    required this.timeZone,
    required this.geoPosition,
    required this.isAlias,
    required this.parentCity,
    required this.supplementalAdminAreas,
    required this.dataSets,
  });

  factory LocationDTO.fromJson(Map<String, dynamic> json) => _$LocationDTOFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.pascal, createToJson: false)
class AdministrativeAreaDTO {
  @JsonKey(name: 'ID')
  final String id;
  final String localizedName;
  final String englishName;
  final int level;
  final String localizedType;
  final String englishType;

  @JsonKey(name: 'CountryID')
  final String countryId;

  AdministrativeAreaDTO({
    required this.id,
    required this.localizedName,
    required this.englishName,
    required this.level,
    required this.localizedType,
    required this.englishType,
    required this.countryId,
  });

  factory AdministrativeAreaDTO.fromJson(Map<String, dynamic> json) => _$AdministrativeAreaDTOFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.pascal, createToJson: false)
class CountryDTO {
  @JsonKey(name: 'ID')
  final String id;
  final String localizedName;
  final String englishName;

  CountryDTO({
    required this.id,
    required this.localizedName,
    required this.englishName,
  });

  factory CountryDTO.fromJson(Map<String, dynamic> json) => _$CountryDTOFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.pascal, createToJson: false)
class GeoPositionDTO {
  final double latitude;
  final double longitude;
  final ElevationDTO elevation;

  GeoPositionDTO({
    required this.latitude,
    required this.longitude,
    required this.elevation,
  });

  factory GeoPositionDTO.fromJson(Map<String, dynamic> json) => _$GeoPositionDTOFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.pascal, createToJson: false)
class ElevationDTO {
  final ImperialDTO metric;
  final ImperialDTO imperial;

  ElevationDTO({
    required this.metric,
    required this.imperial,
  });

  factory ElevationDTO.fromJson(Map<String, dynamic> json) => _$ElevationDTOFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.pascal, createToJson: false)
class ImperialDTO {
  final double value;
  final String unit;
  final int unitType;

  ImperialDTO({
    required this.value,
    required this.unit,
    required this.unitType,
  });

  factory ImperialDTO.fromJson(Map<String, dynamic> json) => _$ImperialDTOFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.pascal, createToJson: false)
class ParentCityDTO {
  final String key;
  final String localizedName;
  final String englishName;

  ParentCityDTO({
    required this.key,
    required this.localizedName,
    required this.englishName,
  });

  factory ParentCityDTO.fromJson(Map<String, dynamic> json) => _$ParentCityDTOFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.pascal, createToJson: false)
class SupplementalAdminAreaDTO {
  final int level;
  final String localizedName;
  final String englishName;

  SupplementalAdminAreaDTO({
    required this.level,
    required this.localizedName,
    required this.englishName,
  });

  factory SupplementalAdminAreaDTO.fromJson(Map<String, dynamic> json) => _$SupplementalAdminAreaDTOFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.pascal, createToJson: false)
class TimeZoneDTO {
  final String code;
  final String name;
  final double gmtOffset;
  final bool isDaylightSaving;
  final dynamic nextOffsetChange;

  TimeZoneDTO({
    required this.code,
    required this.name,
    required this.gmtOffset,
    required this.isDaylightSaving,
    required this.nextOffsetChange,
  });

  factory TimeZoneDTO.fromJson(Map<String, dynamic> json) => _$TimeZoneDTOFromJson(json);
}
