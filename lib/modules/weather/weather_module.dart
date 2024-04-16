import 'package:flutter_modular/flutter_modular.dart';

import '../auth/auth_module.dart';
import 'data/repositories/weather_repository.dart';
import 'domain/usecases/get_all_weather_use_cases.dart';
import 'domain/usecases/get_city_use_cases.dart';
import 'domain/usecases/get_current_city_use_cases.dart';
import 'presentation/store/weather_store.dart';
import 'view/all_weather/all_weather_view.dart';
import 'view/home/home_page_view.dart';

class WeatherModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<WeatherRepository>(WeatherRepositoryImpl.new);
    i.addLazySingleton<GetCityWeatherUsecase>(GetCityWeatherUsecaseImpl.new);
    i.addLazySingleton<GetAllWeatherUsecase>(GetAllWeatherUsecaseImpl.new);
    i.addLazySingleton<GetCurrentCityUsecase>(GetCurrentCityUsecaseImpl.new);
    i.addLazySingleton(WeatherStore.new);
  }

  @override
  List<Module> get imports => [AuthModule()];

  @override
  void routes(RouteManager r) {
    r.child("/home", child: (_) =>  HomePageView(authStore: Modular.get(), weatherStore: Modular.get()));
    r.child("/five_days", child: (_) => const AllWeatherView());
    super.routes(r);
  }
}
