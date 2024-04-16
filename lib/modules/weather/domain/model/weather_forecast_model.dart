import 'weather_data_model.dart';

class WeatherForecast {
  final City city;
  final List<WeatherData> list;

  WeatherForecast({
    required this.list,
    required this.city,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      city: City.fromJson(json['city']),
      list: json["list"] != null
          ? (json['list'] as List)
              .map((item) => WeatherData.fromJson(item))
              .toList()
          : [],
    );
  }
}

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
