import 'dart:math';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  String cityName = '';
  String temperature = '--';
  String weatherCondition = '--';
  List<Map<String, String>> sevenDayForecast = [];
  List<String> weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  void fetchWeather() {
    setState(() {
      cityName = _cityController.text;

      // Generate random temperature between 15°C and 30°C
      int temp = Random().nextInt(16) + 15;
      temperature = '$temp°C';

      // Randomly select a weather condition
      List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
      weatherCondition = conditions[Random().nextInt(3)];
    });
  }

  void fetchSevenDayForecast() {
    setState(() {
      cityName = _cityController.text;

      // Generate random data for 7 days
      List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
      sevenDayForecast = List.generate(7, (index) {
        int temp = Random().nextInt(16) + 15;
        String condition = conditions[Random().nextInt(3)];
        return {
          'day': weekDays[index],
          'temperature': '$temp°C',
          'condition': condition,
        };
      });
    });
  }

  IconData getWeatherIcon(String condition) {
    switch (condition) {
      case 'Sunny':
        return Icons.wb_sunny;
      case 'Cloudy':
        return Icons.cloud;
      case 'Rainy':
        return Icons.umbrella;
      default:
        return Icons.help_outline; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/weather.jpg'), // Dummy path to your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TextField for city input
                TextField(
                  controller: _cityController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelText: 'Enter City Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // Fetch Weather Button
                ElevatedButton(
                  onPressed: fetchWeather,
                  child: const Text('Fetch Weather'),
                ),
                const SizedBox(height: 16),
                // Fetch 7-Day Forecast Button
                ElevatedButton(
                  onPressed: fetchSevenDayForecast,
                  child: const Text('Fetch 7-Day Forecast'),
                ),
                const SizedBox(height: 32),
                // Placeholders for Weather Data
                Text(
                  'City: $cityName',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Temperature: $temperature',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      getWeatherIcon(weatherCondition),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      weatherCondition,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // 7-Day Forecast Section
                sevenDayForecast.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: sevenDayForecast.length,
                          itemBuilder: (context, index) {
                            final forecast = sevenDayForecast[index];
                            return ListTile(
                              leading: Icon(
                                getWeatherIcon(forecast['condition']!),
                              ),
                              title: Text(
                                '${forecast['day']} - ${forecast['temperature']}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Text(forecast['condition']!),
                            );
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
