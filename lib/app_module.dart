import 'package:flutter_modular/flutter_modular.dart';
import 'package:forecast_app/modules/auth/auth_module.dart';
import 'package:forecast_app/core/pages/splash/splash.dart';
import 'package:forecast_app/modules/weather/weather_module.dart';
class AppModule extends Module {
  @override
  List<Module> get imports => [AuthModule()];

  @override
  void routes(RouteManager r) {
    r.child("/", child: (_) => const SplashPage());
    r.module("/auth", module: AuthModule());
    r.module("/weather", module: WeatherModule());
  }
}
