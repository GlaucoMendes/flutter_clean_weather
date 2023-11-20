class Location {
  final String key;
  final String name;
  final Country region;
  final Country country;
  final AdministrativeArea administrativeArea;

  Location({
    required this.key,
    required this.name,
    required this.region,
    required this.country,
    required this.administrativeArea,
  });
}

class AdministrativeArea {
  final String id;
  final String name;

  AdministrativeArea({
    required this.id,
    required this.name,
  });
}

class Country {
  final String id;
  final String name;

  Country({
    required this.id,
    required this.name,
  });
}
