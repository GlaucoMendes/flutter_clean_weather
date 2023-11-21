import '../../../data/dtos/accu/location_dto.dart';
import '../../../domain/entities/location.dart';

class LocationMapper {
  static Location fromDTO(LocationDTO dto) {
    return Location(
      key: dto.key,
      name: dto.localizedName,
      region: dto.region.localizedName,
      country: dto.country.localizedName,
      area: dto.administrativeArea.localizedName,
      areaId: dto.administrativeArea.id,
    );
  }
}
