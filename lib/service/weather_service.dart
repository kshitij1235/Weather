

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String API_KEY;

  WeatherService({
    required this.API_KEY
  });

  Future<Weather> getweather(String cityname)async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityname&appid=$API_KEY&unit=metric'));

    if(response.statusCode == 200){
      return  Weather.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception("Failed to get the weather data");
    }

  }


  Future<String> getcurrentlocation() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
    );


    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, 
    position.longitude);

  return placemark[0].locality ?? "";

  }
}