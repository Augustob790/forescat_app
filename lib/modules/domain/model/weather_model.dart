import 'dart:core';

class WeatherModel {
  String cityName;
  double temp;
  String condition;

  WeatherModel({
    required this.cityName,
    required this.temp,
    required this.condition,
  });

  static WeatherModel fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      cityName: map['name'] ?? "",
      temp: map['main']['temp'] ?? 0.0,
      condition: map['weather'][0]['main'] ?? "",
    );
  }
}
