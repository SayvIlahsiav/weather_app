import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = 'df5e28ae623e07f986573be4a43bd4a2';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel> fetchWeatherByLocation(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch weather');
    }
  }

  Future<WeatherModel> fetchWeatherByCity(String city) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch weather');
    }
  }
}
