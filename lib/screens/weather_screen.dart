import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var weatherProvider = Provider.of<WeatherProvider>(context);

    if (weatherProvider.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    var weather = weatherProvider.weather;

    // Constructing the weather icon URL from the icon code provided by the API.
    String iconUrl = "https://openweathermap.org/img/wn/${weather!.weatherIcon}@2x.png";

    // Getting the current date, time, and day
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(now);
    String formattedTime = DateFormat('HH:mm').format(now);
    String formattedDay = DateFormat('EEEE').format(now);

    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                weather.cityName,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '$formattedDay, $formattedDate',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              Text(
                formattedTime,
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              // Display the weather icon here
              Image.network(
                iconUrl,
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 100); // Fallback in case the icon fails to load
                },
              ),
              SizedBox(height: 20),
              Text(
                '${weather.temperature.toInt()}°C',
                style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                weather.description,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(CupertinoIcons.drop, size: 40),
                      SizedBox(height: 16),
                      Text('${weather.humidity}%', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 4),
                      Text('Humidity', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(CupertinoIcons.cloud_rain, size: 40),
                      SizedBox(height: 16),
                      Text('${weather.rainChances}%', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 4),
                      Text('Precipitation', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
