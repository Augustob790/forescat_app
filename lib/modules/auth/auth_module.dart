import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/auth_store.dart';
import 'services/firebase_services.dart';
import 'view/create_account/create_account_view.dart';
import 'view/login/login_view.dart';

class AuthModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton(AuthStore.new);
    i.add(FirebaseAuthService.new);
    super.exportedBinds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child("/login", child: (_) => LoginPage(authStore: Modular.get()));
    r.child("/sign", child: (_) => SignPageView(authStore: Modular.get()));
    super.routes(r);
  }
}
