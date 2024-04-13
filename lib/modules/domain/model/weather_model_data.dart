class WeatherData {
  final List<Weather> weather;
  final Main main;
  final Wind wind;
  final String name;

  WeatherData({
    required this.weather,
    required this.main,
    required this.wind,
    required this.name,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      weather: (json['weather'] as List).map((item) => Weather.fromJson(item)).toList(),
      main: Main.fromJson(json['main']),
      wind: Wind.fromJson(json['wind']),
      name: json['name'] ?? "",
    );
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({required this.id, required this.main, required this.description, required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'] ?? "", 
      main: json['main'] ?? "",
      description: json['description'] ?? "",
      icon: json['icon'] ?? "",
    );
  }
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'] ?? "",
      feelsLike: json['feels_like'] ?? "",
      tempMin: json['temp_min'] ?? "",
      tempMax: json['temp_max'] ?? "",
      pressure: json['pressure'] ?? "",
      humidity: json['humidity'] ?? "",
      seaLevel: json['sea_level'] ?? "",
      grndLevel: json['grnd_level'] ?? "",
    );
  }
}

class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'] ?? "",
      deg: json['deg'] ?? "",
      gust: json['gust'] ?? "",
    );
  }
}

