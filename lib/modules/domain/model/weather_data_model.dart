class Main {
  final dynamic temp;
  final dynamic tempMin;
  final dynamic tempMax;
  final dynamic humidity;
  final dynamic feelsLike;

  Main({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.feelsLike,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'] ?? "",
      tempMin: json['temp_min'] ?? 0.0,
      tempMax: json['temp_max'] ?? 0.0,
      humidity: json['humidity'] ?? 0,
      feelsLike: json['feels_like'] ?? 0,
    );
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Wind {
  final dynamic speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'] ?? "",
    );
  }
}

class City {
  final String name;

  City({required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] ?? "",
    );
  }
}
