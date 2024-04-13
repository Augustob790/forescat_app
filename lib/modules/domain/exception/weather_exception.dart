class WeatherException implements Exception {
  final String message;

  WeatherException({required this.message});

  WeatherException.generic()
      : message = 'Não foi possivel se conectar com o servidor!.';
}
