import 'package:flutter_clean_weather/data/dtos/accu/location_dto.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

class LocationMapper {
  static Location fromDTO(LocationDTO dto) {
    return Location(
      key: dto.key,
      name: dto.localizedName,
      region: fromDTOCountry(dto.region),
      country: fromDTOCountry(dto.country),
      administrativeArea: fromDTOAdministrativeArea(dto.administrativeArea),
    );
  }

  static Country fromDTOCountry(CountryDTO dto) {
    return Country(
      id: dto.id,
      name: dto.localizedName,
    );
  }

  static AdministrativeArea fromDTOAdministrativeArea(AdministrativeAreaDTO dto) {
    return AdministrativeArea(
      id: dto.id,
      name: dto.localizedName,
    );
  }
}
