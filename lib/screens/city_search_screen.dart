import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';

class CitySearchScreen extends StatefulWidget {
  @override
  _CitySearchScreenState createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController _cityController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _searchCity(BuildContext context) async {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    final city = _cityController.text;

    if (city.isNotEmpty) {
      setState(() {
        _isSearching = true;
      });

      try {
        await weatherProvider.fetchWeatherByCity(city);
        Navigator.pop(
            context); // Go back to the weather screen after the search
      } catch (error) {
        // Handle any errors such as city not found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('City not found, please try again!')),
        );
      } finally {
        setState(() {
          _isSearching = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search City'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) =>
                  _searchCity(context), // Trigger search on enter
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSearching ? null : () => _searchCity(context),
              child: _isSearching
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
