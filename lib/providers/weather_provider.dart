import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? weather;
  bool isLoading = true;

  final WeatherService _weatherService = WeatherService();

  Future<void> fetchWeatherByLocation(double lat, double lon) async {
    isLoading = true;
    notifyListeners();
    weather = await _weatherService.fetchWeatherByLocation(lat, lon);
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchWeatherByCity(String city) async {
    isLoading = true;
    notifyListeners();
    weather = await _weatherService.fetchWeatherByCity(city);
    isLoading = false;
    notifyListeners();
  }
}
