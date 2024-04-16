// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:forecast_app/modules/auth/services/firebase_auth_services.dart';
import '../../../../core/const/image_constant.dart';
import 'widget/custom_container.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/get_error_ui.dart';
import '../../../../core/widgets/load_ui.dart';
import '../../presentation/store/weather_store.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/helpers/theme_helper.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late final WeatherStore weatherStore;
  final auth = Modular.get<FirebaseAuthService>();
  String city = " ";

  @override
  void initState() {
    super.initState();
    weatherStore = Modular.get<WeatherStore>();
    inicialize();
  }

  inicialize() async {
    await weatherStore.getCurrentCity();
    await weatherStore.getCityWeather(weatherStore.city);
    await weatherStore.getAllWeather(weatherStore.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            auth.logout();
            Modular.to.pushReplacementNamed('/auth/login');
          },
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
        ),
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
            onPressed: () {
              inicialize();
            },
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
      ),
      body: Center(
        child: Observer(
          builder: (context) {
            if (weatherStore.isLoading == "isLoading") {
              return const LoadUi();
            } else if (weatherStore.errorMessage == "error") {
              return const GetErrorUi(error: "Error");
            } else if (weatherStore.weather != null &&
                weatherStore.isLoading == "sucess") {
              return getBodyUI();
            } else {
              return const LoadUi();
            }
          },
        ),
      ),
    );
  }

  Widget getBodyUI() {
    return Container(
      padding: EdgeInsets.all(10),
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
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(
                top: 140,
                bottom: 10,
              ),
              child: Center(
                child: CustomText(
                  text: Helpers.weekdayNameView,
                  fontSize: 18.35,
                  height: 0.08,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
            padding: const EdgeInsets.all(10),
            child: CustomImageView(
              imagePath: Helpers.imageClima(
                  weatherStore.weather?.list.first.weather.first.main ??
                      "Clear"),
              height: 122,
              width: 130,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weatherStore.weather?.list.first.main.temp.toStringAsFixed(1) ??
                    "",
                style: theme.textTheme.displayLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  width: 6.65,
                  height: 6,
                  decoration: const ShapeDecoration(
                    shape: OvalBorder(
                      side: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomText(
                  text: Helpers.dateForBR,
                  fontSize: 13,
                  height: 0.12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomText(
                  text:
                      "Feels Like: ${weatherStore.weather?.list.first.main.feelsLike.toStringAsFixed(1)}˚",
                  fontSize: 13,
                  height: 0.12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: CustomText(
                  text: "Infos",
                  fontSize: 18,
                  height: 0.12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextButton(
                  onPressed: () {
                    Modular.to.pushNamed("/weather/five_days");
                  },
                  child: CustomText(
                    text: "Next 5 days > ",
                    fontSize: 18,
                    height: 0.12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomContainer(
                text: "Min",
                info:
                    "${weatherStore.weather?.list.first.main.tempMin.toString()}˚",
              ),
              CustomContainer(
                text: "Max",
                info:
                    "${weatherStore.weather?.list.first.main.tempMax.toString()}˚",
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomContainer(
                text: "Humidity",
                info:
                    "${weatherStore.weather?.list.first.main.humidity.toString()}%",
              ),
              CustomContainer(
                text: "Wind",
                info:
                    "${weatherStore.weather?.list.first.wind.speed.toString()} Km/h",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
