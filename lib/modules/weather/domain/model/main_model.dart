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