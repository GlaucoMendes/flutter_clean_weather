import 'package:flutter_clean_weather/data/dtos/location_dto.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

class LocationMapper {
  static Location fromDTO(LocationDTO dto) {
    return Location(
      version: dto.version,
      key: dto.key,
      type: dto.type,
      rank: dto.rank,
      localizedName: dto.localizedName,
      englishName: dto.englishName,
      primaryPostalCode: dto.primaryPostalCode,
      region: fromDTOCountry(dto.region),
      country: fromDTOCountry(dto.country),
      administrativeArea: fromDTOAdministrativeArea(dto.administrativeArea),
      timeZone: fromDTOTimeZone(dto.timeZone),
      geoPosition: fromDTOGeoPosition(dto.geoPosition),
      isAlias: dto.isAlias,
      parentCity: fromDTOParentCity(dto.parentCity),
      supplementalAdminAreas: dto.supplementalAdminAreas.map(fromDTOSupplementalAdminArea).toList(),
      dataSets: dto.dataSets,
    );
  }

  static Country fromDTOCountry(CountryDTO dto) {
    return Country(
      id: dto.id,
      localizedName: dto.localizedName,
      englishName: dto.englishName,
    );
  }

  static AdministrativeArea fromDTOAdministrativeArea(AdministrativeAreaDTO dto) {
    return AdministrativeArea(
      id: dto.id,
      localizedName: dto.localizedName,
      englishName: dto.englishName,
      level: dto.level,
      localizedType: dto.localizedType,
      englishType: dto.englishType,
      countryId: dto.countryId,
    );
  }

  static GeoPosition fromDTOGeoPosition(GeoPositionDTO dto) {
    return GeoPosition(
      latitude: dto.latitude,
      longitude: dto.longitude,
      elevation: fromDTOElevation(dto.elevation),
    );
  }

  static Elevation fromDTOElevation(ElevationDTO dto) {
    return Elevation(
      metric: fromDTOImperial(dto.metric),
      imperial: fromDTOImperial(dto.imperial),
    );
  }

  static Imperial fromDTOImperial(ImperialDTO dto) {
    return Imperial(
      value: dto.value,
      unit: dto.unit,
      unitType: dto.unitType,
    );
  }

  static TimeZone fromDTOTimeZone(TimeZoneDTO dto) {
    return TimeZone(
      code: dto.code,
      name: dto.name,
      gmtOffset: dto.gmtOffset,
      isDaylightSaving: dto.isDaylightSaving,
      nextOffsetChange: dto.nextOffsetChange,
    );
  }

  static ParentCity? fromDTOParentCity(ParentCityDTO? dto) {
    if (dto == null) return null;

    return ParentCity(
      key: dto.key,
      localizedName: dto.localizedName,
      englishName: dto.englishName,
    );
  }

  static SupplementalAdminArea fromDTOSupplementalAdminArea(SupplementalAdminAreaDTO dto) {
    return SupplementalAdminArea(
      level: dto.level,
      localizedName: dto.localizedName,
      englishName: dto.englishName,
    );
  }
}
