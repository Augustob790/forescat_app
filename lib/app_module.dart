import 'package:flutter_modular/flutter_modular.dart';
import 'package:forecast_app/modules/presentation/store/auth_store.dart';
import 'package:forecast_app/modules/services/auth_services.dart';
import 'package:forecast_app/modules/view/all_weather/all_weather_view.dart';
import 'package:forecast_app/modules/view/splash/splash.dart';

import 'modules/data/repositories/weather_repository.dart';
import 'modules/domain/usecases/get_all_weather_use_cases.dart';
import 'modules/domain/usecases/get_city_use_cases.dart';
import 'modules/domain/usecases/get_current_city_use_cases.dart';
import 'modules/presentation/home_page_view_model.dart';
import 'modules/presentation/store/weather_store.dart';
import 'modules/view/auth/create_account_view.dart';
import 'modules/view/home/home_page_view.dart';
import 'modules/view/auth/login_view.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<WeatherRepository>(WeatherRepositoryImpl.new);
    i.addLazySingleton<GetCityWeatherUsecase>(GetCityWeatherUsecaseImpl.new);
    i.addLazySingleton<GetAllWeatherUsecase>(GetAllWeatherUsecaseImpl.new);
    i.addLazySingleton<GetCurrentCityUsecase>(GetCurrentCityUsecaseImpl.new);
    i.addLazySingleton(WeatherStore.new);
    i.addLazySingleton(AuthStore.new);
    i.add(AuthService.new);
    i.add(HomePageViewModel.new);
  }

  @override
  void routes(RouteManager r) {
    r.child("/", child: (_) => const SplashPage());
    r.child("/login", child: (_) => const LoginPage());
    r.child("/sign", child: (_) => const SignPageView());
    r.child("/home", child: (_) => const HomePageView());
    r.child("/five_days", child: (_) => const AllWeatherView());
  }
}
