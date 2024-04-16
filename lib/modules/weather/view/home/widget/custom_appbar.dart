import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/helpers/theme_helper.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../presentation/store/weather_store.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.onPressed, required this.weatherStore});

  final void Function()? onPressed;
  final WeatherStore weatherStore;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.5, 0.5),
            end: const Alignment(0.5, 2.5),
            colors: [appTheme.indigo900, appTheme.blueGray700],
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white, // Cor do ícone
      ),
      elevation: 0,
      title: Observer(builder: (context) {
        return CustomText(
          text: weatherStore.weather?.city.name ?? "",
          color: Colors.white,
          fontSize: 18,
          height: 0.10,
          fontWeight: FontWeight.w600,
        );
      }),
      actions: [
        IconButton(
          onPressed: onPressed,
          padding: const EdgeInsets.all(0),
          icon: const SizedBox(
            width: 40,
            height: 40,
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
