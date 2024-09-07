import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../services/location_service.dart';
import 'weather_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    // Delay provider access after widget initialization
    Future.microtask(() => _detectLocationAndFetchWeather());
  }

  void _detectLocationAndFetchWeather() async {
    try {
      var position = await _locationService.getCurrentLocation();
      await Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeatherByLocation(position.latitude, position.longitude);
      // Navigate to the weather screen after fetching data
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WeatherScreen()));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
