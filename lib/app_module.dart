import 'package:flutter_modular/flutter_modular.dart';
import 'package:forecast_app/modules/auth/auth_module.dart';
import 'package:forecast_app/core/pages/splash/splash.dart';
import 'package:forecast_app/modules/weather/weather_module.dart';

import 'core/notifications/notifications_manager.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [AuthModule()];

  @override
  void exportedBinds(Injector i) {
    i.add(NotificationsManager.new);
    super.exportedBinds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child("/", child: (_) => SplashPage(service: Modular.get()));
    r.module("/auth", module: AuthModule());
    r.module("/weather", module: WeatherModule());
  }
}
