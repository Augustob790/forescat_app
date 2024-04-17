import 'package:geolocator/geolocator.dart';

import '../../data/repositories/weather_repository.dart';

abstract class GetCurrentCityUsecase {
  Future<Position> call();
}

class GetCurrentCityUsecaseImpl implements GetCurrentCityUsecase {
  final WeatherRepository repository;

  GetCurrentCityUsecaseImpl({required this.repository});

  @override
  Future<Position> call() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.unableToDetermine) {
        permission = await Geolocator.requestPermission();
      }

      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        throw "Permissão não concedida!";
      }

      return repository.getPosition();
    } catch (e) {
      throw e.toString();
    }
  }
}
