import 'package:flutter/material.dart';

import '../../../../../core/const/app_decoration.dart';
import '../../../../../core/helpers/helpers.dart';
import '../../../../../core/helpers/theme_helper.dart';
import '../../../../../core/widgets/custom_image_view.dart';
import '../../../domain/model/weather_forecast_model.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.list});

  final List<WeatherData> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
      padding: const EdgeInsets.all(10.0),
      decoration: AppDecoration.gradientDeepPurpleToBlueGray.copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
      child: Column(
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomImageView(
                  imagePath: Helpers.imageClima(list.first.weather.first.main),
                  height: 50,
                  width: 50,
                ),
                Text(
                  "${list.first.main.temp.toStringAsFixed(1)}˚",
                  style: theme.textTheme.displayLarge,
                ),
              ]),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Min: ${list.first.main.tempMin.toStringAsFixed(1)}˚ ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                Text(
                  "Max: ${list.first.main.tempMax.toStringAsFixed(1)}˚ ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ]),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Humidity: ${list.first.main.humidity}% ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                Text(
                  "Feels Like: ${list.first.main.feelsLike.toStringAsFixed(1)}˚",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
