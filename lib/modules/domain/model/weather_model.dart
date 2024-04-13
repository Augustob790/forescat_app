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

// class WeatherData {
//   String condition;
//   num temperature;
//   num feelsLike;
//   num pressure;
//   num visibility;
//   String humidity;
//   num windSpeed;
//   String country;
//   String name;
//   String icon;

//   WeatherData(
//       {this.condition,
//       this.temperature,
//       this.feelsLike,
//       this.visibility,
//       this.pressure,
//       this.humidity,
//       this.windSpeed,
//       this.country,
//       this.name,
//       this.icon});

//   factory WeatherData.fromJson(Map<String, dynamic> json) {
//     return WeatherData(
//       condition: json['weather'][0]['main'],
//       temperature: (json['main']['temp']).round(),
//       feelsLike: (json['main']['feels_like']).round(),
//       visibility: (json['visibility'] / 1000).round(),
//       pressure: (json['main']['pressure']),
//       humidity: json['main']['humidity'].toString(),
//       windSpeed: (json['wind']['speed'] * 3.6),
//       country: json['sys']['country'],
//       name: json['name'],
//       icon: json['weather'][0]['icon'],
//     );
//   }
// }
