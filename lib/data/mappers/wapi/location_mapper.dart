import '../../../domain/entities/location.dart';
import '../../dtos/wapi/location_dto.dart';

class LocationMapper {
  static Location fromDTO(LocationDTO dto) {
    return Location(
      key: dto.id.toString(),
      name: dto.name,
      region: dto.region,
      country: dto.country,
      area: dto.region,
      areaId: '',
    );
  }
}
