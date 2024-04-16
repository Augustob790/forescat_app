class Wind {
  final dynamic speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'] ?? "",
    );
  }
}