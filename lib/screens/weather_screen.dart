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
                style: TextStyle(fontSize: 32),
              ),
              Text(
                '$formattedDay, $formattedDate',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                formattedTime,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              // Display the weather icon here
              Image.network(
                iconUrl,
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error); // Fallback in case the icon fails to load
                },
              ),
              SizedBox(height: 20),
              Text(
                '${weather.temperature.toInt()}°C',
                style: TextStyle(fontSize: 64),
              ),
              Text(
                weather.description,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(CupertinoIcons.drop),
                      SizedBox(height: 20),
                      Text('${weather.humidity}%'),
                      SizedBox(height: 20),
                      Text('Humidity'),
                      SizedBox(height: 20),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(CupertinoIcons.cloud_rain),
                      SizedBox(height: 20),
                      Text('${weather.rainChances}%'),
                      SizedBox(height: 20),
                      Text('Precipitation'),
                      SizedBox(height: 20),
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
