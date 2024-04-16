// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:forecast_app/core/const/api.dart';

import '../../const/image_constant.dart';
import '../../helpers/helpers.dart';
import '../../helpers/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../../../modules/auth/services/firebase_services.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.service});

  final FirebaseAuthService service;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTimeout() {
    return Timer(const Duration(seconds: 5), verificationAuth);
  }

  verificationAuth() async {
    if (widget.service.usuario == null) {
      Modular.to.pushReplacementNamed('/auth/login');
    } else {
      Modular.to.pushReplacementNamed('/weather/home');
    }
  }

  @override
  void initState() {
    super.initState();
    Apis();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              opacity: 0.2,
              image: AssetImage(ImageConstant.imgGroup88),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: CustomImageView(
                  imagePath: Helpers.imageClima("Clear"),
                  height: 122,
                  width: 130,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
