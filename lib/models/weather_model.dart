class Weather {
  final String cityname;
  final double temp;
  final String condition;

  Weather({
    required this.cityname,
    required this.temp,
    required this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityname: json['name'],
      temp: json['main']['temp'].toDouble(), 
      condition: json['weather'][0]['main'],
    );
  }
}
