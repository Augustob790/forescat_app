import '../../data/repositories/weather_repository.dart';
import '../exception/weather_exception.dart';
import '../model/weather_model.dart';

abstract class GetCityWeatherUsecase {
  Future<WeatherModel> call(String cityname);
}

class GetCityWeatherUsecaseImpl implements GetCityWeatherUsecase {
  final WeatherRepository repository;

  GetCityWeatherUsecaseImpl({required this.repository});

  @override
  Future<WeatherModel> call(cityName) async {
    try {
      return repository.getCityWeather(cityName);
    } on WeatherException {
      rethrow;
    }
  }
}
