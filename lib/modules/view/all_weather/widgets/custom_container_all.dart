import 'package:flutter/material.dart';
import 'package:forecast_app/core/helpers/helpers.dart';
import 'package:forecast_app/core/widgets/custom_image_view.dart';

class CustomContainerAll extends StatelessWidget {
  const CustomContainerAll(
      {super.key,
      required this.weekDay,
      required this.imageWeather,
      required this.max,
      required this.min});

  final String imageWeather;
  final String weekDay;
  final String max;
  final String min;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              weekDay,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          CustomImageView(
              imagePath: Helpers.imageClima(imageWeather),
              height: 40,
              width: 41),
          Text(
            "Min: $min ",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Text(
            "Max: $max",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
