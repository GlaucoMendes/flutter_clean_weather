import 'package:flutter/material.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  const LocationTile({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    final areaId = location.areaId.isEmpty ? '' : '(${location.areaId}) ';
    return ListTile(
      title: Text(location.name),
      subtitle: Text(
        '${location.area} $areaId- ${location.country}',
      ),
      trailing: const Icon(Icons.push_pin_outlined),
    );
  }
}
