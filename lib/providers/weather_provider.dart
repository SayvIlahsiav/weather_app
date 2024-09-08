import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? weather;
  bool isLoading = true;
  String? _lastCity;
  double? _lastLatitude;
  double? _lastLongitude;

  final WeatherService _weatherService = WeatherService();

  // Fetch weather by coordinates (latitude and longitude)
  Future<void> fetchWeatherByLocation(double lat, double lon) async {
    _setLoadingState(true);
    try {
      weather = await _weatherService.fetchWeatherByLocation(lat, lon);
      _lastLatitude = lat;
      _lastLongitude = lon;
    } catch (error) {
      _handleError(error);
    }
    _setLoadingState(false);
  }

  // Fetch weather by city name
  Future<void> fetchWeatherByCity(String city) async {
    _setLoadingState(true);
    try {
      weather = await _weatherService.fetchWeatherByCity(city);
      _lastCity = city;
    } catch (error) {
      _handleError(error);
    }
    _setLoadingState(false);
  }

  // Fetch the current device location and get weather for that location
  Future<void> fetchWeatherByCurrentLocation() async {
    _setLoadingState(true);
    try {
      Position position = await _getCurrentPosition();
      await fetchWeatherByLocation(position.latitude, position.longitude);
    } catch (error) {
      _handleError(error);
    }
    _setLoadingState(false);
  }

  // Method to get current location
  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    // Return the current position
    return await Geolocator.getCurrentPosition();
  }

  // Set loading state and notify listeners
  void _setLoadingState(bool state) {
    isLoading = state;
    notifyListeners();
  }

  // Handle errors
  void _handleError(dynamic error) {
    print("Error occurred: $error");
    // Optionally, notify the user or log the error in more detail
  }
}
