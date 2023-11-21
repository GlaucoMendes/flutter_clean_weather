enum WeatherApi {
  accuweather(instanceName: 'accuweather'),
  weatherapi(instanceName: 'weatherapi');

  final String instanceName;
  const WeatherApi({required this.instanceName});
}
