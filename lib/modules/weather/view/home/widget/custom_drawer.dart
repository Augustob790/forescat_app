import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forecast_app/modules/auth/services/firebase_services.dart';

import '../../../../../core/const/image_constant.dart';
import '../../../../../core/helpers/theme_helper.dart';
import '../../../../auth/presentation/auth_store.dart';
import '../../../presentation/store/weather_store.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key,required this.weatherStore,required this.authStore, required this.service});

  final WeatherStore weatherStore;
  final AuthStore authStore;
  final FirebaseAuthService service;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: const Alignment(0.5, 0),
                  end: const Alignment(0.5, 1),
                  colors: [
                    appTheme.indigo90001,
                    appTheme.indigo900,
                  ]),
              image: DecorationImage(
                  opacity: 0.2,
                  image: AssetImage(ImageConstant.imgGroup88),
                  fit: BoxFit.cover),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(
                      authStore.userModel?.photoImage == null
                          ? service.usuario?.photoURL ?? ""
                          : authStore.userModel?.photoImage ?? ""),
                ),
                const SizedBox(height: 10),
                Text(
                  authStore.userModel?.email == null
                      ? service.usuario?.email ?? ""
                      : authStore.userModel?.email ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            trailing: IconButton(
              onPressed: () async {
                await authStore.logout();
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
            ),
            title: const Text('Sair'),
            onTap: () async {
              await authStore.logout();
            },
          ),
        ],
      ),
    );
  }
}
