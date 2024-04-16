import 'city_model.dart';
import 'weather_data.dart';

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


