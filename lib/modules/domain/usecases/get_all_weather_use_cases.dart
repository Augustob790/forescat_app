import '../../data/repositories/weather_repository.dart';
import '../exception/weather_exception.dart';
import '../model/weather_forecast_model.dart';

abstract class GetAllWeatherUsecase {
  Future<WeatherForecast> call(String cityname);
}

class GetAllWeatherUsecaseImpl implements GetAllWeatherUsecase {
  final WeatherRepository repository;

  GetAllWeatherUsecaseImpl({required this.repository});

  @override
  Future<WeatherForecast> call(String cityname) async {
    try {
      return repository.getAllWeather(cityname);
    } on WeatherException {
      rethrow;
    }
  }
}
