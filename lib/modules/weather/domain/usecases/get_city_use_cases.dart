import 'package:geolocator/geolocator.dart';

import '../../data/repositories/weather_repository.dart';
import '../exception/weather_exception.dart';
import '../model/weather_forecast_model.dart';

abstract class GetCityWeatherUsecase {
  Future<WeatherForecast> call(Position position);
}

class GetCityWeatherUsecaseImpl implements GetCityWeatherUsecase {
  final WeatherRepository repository;

  GetCityWeatherUsecaseImpl({required this.repository});

  @override
  Future<WeatherForecast> call(Position position) async {
    try {
      return repository.getCityWeather(position);
    } on WeatherException {
      rethrow;
    }
  }
}
