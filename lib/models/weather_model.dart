class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final int rainChances;
  final String weatherIcon;

  WeatherModel(
      {required this.cityName,
      required this.temperature,
      required this.description,
      required this.humidity,
      required this.rainChances,
      required this.weatherIcon});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        cityName: json['name'],
        temperature: json['main']['temp'],
        description: json['weather'][0]['description'],
        humidity: json['main']['humidity'],
        rainChances: json['main']['humidity'],
        weatherIcon: json['weather']['0']['icon']);
  }
}
