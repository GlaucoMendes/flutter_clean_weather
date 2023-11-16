// TODO(Glauco): Remover todos os campos não utilizados
class Location {
  final int version;
  final String key;
  final String type;
  final int rank;
  final String localizedName;
  final String englishName;
  final String primaryPostalCode;
  final Country region;
  final Country country;
  final AdministrativeArea administrativeArea;
  final TimeZone timeZone;
  final GeoPosition geoPosition;
  final bool isAlias;
  final ParentCity? parentCity;
  final List<SupplementalAdminArea> supplementalAdminAreas;
  final List<String> dataSets;

  Location({
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
}

class AdministrativeArea {
  final String id;
  final String localizedName;
  final String englishName;
  final int level;
  final String localizedType;
  final String englishType;
  final String countryId;

  AdministrativeArea({
    required this.id,
    required this.localizedName,
    required this.englishName,
    required this.level,
    required this.localizedType,
    required this.englishType,
    required this.countryId,
  });
}

class Country {
  final String id;
  final String localizedName;
  final String englishName;

  Country({
    required this.id,
    required this.localizedName,
    required this.englishName,
  });
}

class GeoPosition {
  final double latitude;
  final double longitude;
  final Elevation elevation;

  GeoPosition({
    required this.latitude,
    required this.longitude,
    required this.elevation,
  });
}

class Elevation {
  final Imperial metric;
  final Imperial imperial;

  Elevation({
    required this.metric,
    required this.imperial,
  });
}

class Imperial {
  final double value;
  final String unit;
  final int unitType;

  Imperial({
    required this.value,
    required this.unit,
    required this.unitType,
  });
}

class ParentCity {
  final String key;
  final String localizedName;
  final String englishName;

  ParentCity({
    required this.key,
    required this.localizedName,
    required this.englishName,
  });
}

class SupplementalAdminArea {
  final int level;
  final String localizedName;
  final String englishName;

  SupplementalAdminArea({
    required this.level,
    required this.localizedName,
    required this.englishName,
  });
}

class TimeZone {
  final String code;
  final String name;
  final double gmtOffset;
  final bool isDaylightSaving;
  final dynamic nextOffsetChange;

  TimeZone({
    required this.code,
    required this.name,
    required this.gmtOffset,
    required this.isDaylightSaving,
    required this.nextOffsetChange,
  });
}
