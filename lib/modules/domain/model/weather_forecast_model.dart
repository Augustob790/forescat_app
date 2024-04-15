import 'weather_data_model.dart';

class WeatherForecast {
  final List<WeatherData> list;

  WeatherForecast({
    required this.list,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      list: json["list"] != null ? (json['list'] as List).map((item) => WeatherData.fromJson(item)).toList() : [],
    );
  }
}

class WeatherData {
  final Main main;
  final List<Weather> weather;
  final String date;

  WeatherData({
    required this.main,
    required this.weather,
    required this.date,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: json['dt_txt'] ?? "",
      main: Main.fromJson(json['main']),
      weather:json['weather'] != null ? (json['weather'] as List).map((item) => Weather.fromJson(item)).toList() : [],
    );
  }
}
