import 'weather_data_model.dart';

class WeatherForecast {
  final List<WeatherData> list;

  WeatherForecast({
    required this.list,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      list: (json['list'] as List).map((item) => WeatherData.fromJson(item)).toList(),
    );
  }
}

class WeatherData {
  final Main main;
  final List<Weather> weather;

  WeatherData({
    required this.main,
    required this.weather,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      main: Main.fromJson(json['main']),
      weather: (json['weather'] as List).map((item) => Weather.fromJson(item)).toList(),
    );
  }
}


