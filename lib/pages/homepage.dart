import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/service/weather_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final WeatherService _weatherService = WeatherService(API_KEY: "b257f165f4e1d82b359ac61007133eb9");
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather(); 
  }

  Future<void> _fetchWeather() async {
    try {
      final cityName = await _weatherService.getcurrentlocation();
      print(cityName);

      final weather = await _weatherService.getweather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getConditionAsset(String? condition) {
    if (condition == null) return 'assets/sunny.json';

    switch (condition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'rain':
      case 'thunderstorm':
        return 'assets/${condition.toLowerCase()}.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.bebasNeue(fontSize: 40);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // City name at the top center
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  const Icon(Icons.location_on, size: 50),
                  Text(
                    _weather?.cityname ?? "Loading City...",
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ),

          // Spacer to push the Lottie animation to the middle
          const Spacer(),

          // Lottie animation in the middle center
          Align(
            alignment: Alignment.center,
            child: Lottie.asset(
              getConditionAsset(_weather?.condition?.toUpperCase()),
              height: 250,
            ),
            
          ),

          // Spacer to push the temperature to the bottom
          const Spacer(),

          // Temperature and condition at the bottom center
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              children: [
                Text(
                  '${_weather?.temp.round()} °C',
                  style: textStyle,
                ),
                Text(
                  '${_weather?.condition}',
                  style: textStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
