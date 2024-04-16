import '../../data/repositories/weather_repository.dart';
import '../exception/weather_exception.dart';

abstract class GetCurrentCityUsecase {
  Future<String> call();
}

class GetCurrentCityUsecaseImpl implements GetCurrentCityUsecase {
  final WeatherRepository repository;

  GetCurrentCityUsecaseImpl({required this.repository});

  @override
  Future<String> call() async {
    try {
      return repository.getCity();
    } on WeatherException {
      rethrow;
    }
  }
}


