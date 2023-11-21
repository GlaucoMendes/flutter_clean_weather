import 'package:flutter_clean_weather/data/dtos/wapi/location_dto.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

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
