import 'weather_data_model.dart';

class WeatherModel {
  final List<Weather> weather;
  final Main main;
  final Wind wind;
  final String name;

  WeatherModel({
    required this.weather,
    required this.main,
    required this.wind,
    required this.name,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      weather: (json['weather'] as List).map((item) => Weather.fromJson(item)).toList(),
      main: Main.fromJson(json['main']),
      wind: Wind.fromJson(json['wind']),
      name: json['name'] ?? "",
    );
  }
}




