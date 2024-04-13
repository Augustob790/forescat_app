import '../../data/repositories/weather_repository.dart';
import '../exception/weather_exception.dart';
import '../model/weather_model.dart';

abstract class GetAllWeatherUsecase {
  Future<WeatherModel> call(String cityname);
}

class GetAllWeatherUsecaseImpl implements GetAllWeatherUsecase {
  final WeatherRepository repository;

  GetAllWeatherUsecaseImpl({required this.repository});

  @override
  Future<WeatherModel> call(cityName) async {
    try {
      return repository.getAllWeather(cityName);
    } on WeatherException {
      rethrow;
    }
  }
}
