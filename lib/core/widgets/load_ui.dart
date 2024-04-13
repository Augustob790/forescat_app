import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../helpers/theme_helper.dart';
import '../const/image_constant.dart';

class LoadUi extends StatelessWidget {
  const LoadUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: const Alignment(0.5, 0),
                end: const Alignment(0.5, 1),
                colors: [
                  appTheme.indigo90001,
                  appTheme.indigo900,
                  appTheme.blueGray900
                ]),
            image: DecorationImage(
                image: AssetImage(ImageConstant.imgGroup88),
                fit: BoxFit.cover)),
        child: const Center(
          child: SpinKitFadingCircle(
            color: Colors.purple,
            size: 80,
          ),
        ));
  }
}
