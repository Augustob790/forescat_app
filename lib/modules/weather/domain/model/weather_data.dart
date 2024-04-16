import 'main_model.dart';
import 'weather_data_model.dart';
import 'wind_model.dart';

class WeatherData {
  final Main main;
  final List<Weather> weather;
  final Wind wind;
  final String date;

  WeatherData({
    required this.main,
    required this.weather,
    required this.wind,
    required this.date,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: json['dt_txt'] ?? "",
      wind: Wind.fromJson(json['wind']),
      main: Main.fromJson(json['main']),
      weather: json['weather'] != null
          ? (json['weather'] as List)
              .map((item) => Weather.fromJson(item))
              .toList()
          : [],
    );
  }
}