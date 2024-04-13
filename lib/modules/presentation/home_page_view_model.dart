import 'package:forecast_app/modules/domain/usecases/get_current_city_use_cases.dart';

import '../domain/usecases/get_all_use_cases.dart';

class HomePageViewModel {
  final GetAllWeatherUsecaseImpl getAllWeatherUsecase;
  final GetAllCurrentCityUsecaseImpl getAllCurrentCityUsecase;

  HomePageViewModel({
    required this.getAllWeatherUsecase,
    required this.getAllCurrentCityUsecase,
  });
}
