import 'package:geolocator/geolocator.dart';

import '../../data/repositories/weather_repository.dart';
import '../exception/weather_exception.dart';
import '../model/weather_forecast_model.dart';

abstract class GetAllWeatherUsecase {
  Future<WeatherForecast> call(Position position);
}

class GetAllWeatherUsecaseImpl implements GetAllWeatherUsecase {
  final WeatherRepository repository;

  GetAllWeatherUsecaseImpl({required this.repository});

  @override
  Future<WeatherForecast> call(Position position) async {
    try {
      return repository.getAllWeather(position);
    } on WeatherException {
      rethrow;
    }
  }
}
