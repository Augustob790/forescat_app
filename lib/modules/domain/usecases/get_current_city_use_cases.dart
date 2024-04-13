import '../../data/repositories/weather_repository.dart';
import '../exception/weather_exception.dart';

abstract class GetAllCurrentCityUsecase {
  Future<String> call();
}

class GetAllCurrentCityUsecaseImpl implements GetAllCurrentCityUsecase {
  final WeatherRepository repository;

  GetAllCurrentCityUsecaseImpl({required this.repository});

  @override
  Future<String> call() async {
    try {
      return repository.getCity();
    } on WeatherException {
      rethrow;
    }
  }
}


