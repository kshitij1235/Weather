import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/service/weather_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _WeatherService = WeatherService(API_KEY: "b257f165f4e1d82b359ac61007133eb9");
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather(); 
  }

  _fetchWeather() async {
    String cityname = await _WeatherService.getcurrentlocation();
    print(cityname);
    try {
      final Weather = await _WeatherService.getweather(cityname);
      setState(() {
        _weather = Weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getCondition(String? condition){
    if(condition==null) return 'assets/sunny.json';

  switch(condition.toLowerCase()){
    case 'clouds':
      return 'assets/${condition.toLowerCase()}.json';
    case 'mist':
      return 'assets/${condition.toLowerCase()}.json';
    case 'rain':
      return 'assets/${condition.toLowerCase()}.json';
    case 'thunderstorm':
      return 'assets/${condition.toLowerCase()}.json';
    default:
      return 'assets/${condition.toLowerCase()}.json';
  }

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityname ?? "L O A D I N G  C I T Y ..."),
            Lottie.asset(getCondition(_weather?.condition)),
            Text('${_weather?.temp.round()} °F'),
            Text('${_weather?.condition}'),

          ],
        ),
      ),
    );
  }
}
