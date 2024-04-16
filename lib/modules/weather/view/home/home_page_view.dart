// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:forecast_app/modules/weather/view/home/widget/custom_appbar.dart';
import '../../../../core/const/image_constant.dart';
import '../../../../core/notifications/notifications_manager.dart';
import '../../../../core/widgets/get_error_ui.dart';
import '../../../../core/widgets/load_ui.dart';
import '../../../auth/presentation/auth_store.dart';
import '../../../auth/services/firebase_services.dart';
import 'widget/custom_container.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../presentation/store/weather_store.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/helpers/theme_helper.dart';
import 'widget/custom_drawer.dart';

class HomePageView extends StatefulWidget {
  const HomePageView(
      {super.key,
      required this.weatherStore,
      required this.authStore,
      required this.service});

  final WeatherStore weatherStore;
  final AuthStore authStore;
  final FirebaseAuthService service;

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
    widget.weatherStore.inicialize();
  }

  inicialize() async {
    await widget.weatherStore.getCurrentCity();
    await widget.weatherStore.getCityWeather(widget.weatherStore.city);
    await widget.weatherStore.getAllWeather(widget.weatherStore.city);
    NotificationsManager().showNotification(title: "Atualização", body: "Previsão do tempo atualizada!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        weatherStore: widget.weatherStore,
        onPressed: () async {
          widget.weatherStore.refresh();
        },
      ),
      drawer: CustomDrawer(
          service: widget.service,
          weatherStore: widget.weatherStore,
          authStore: widget.authStore),
      body: Center(
        child: Observer(
          builder: (context) {
            if (widget.weatherStore.isLoading == "isLoading") {
              return const LoadUi();
            } else if (widget.weatherStore.errorMessage == "error") {
              return const GetErrorUi(error: "Error");
            } else if (widget.weatherStore.weather != null && widget.weatherStore.isLoading == "sucess") {
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
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 25),
            child: CustomText(
              text: Helpers.weekdayNameView,
              fontSize: 18.35,
              height: 0.08,
              fontWeight: FontWeight.w600,
            ),
          ),
          CustomImageView(
            imagePath: Helpers.imageClima(
                widget.weatherStore.weather?.list.first.weather.first.main ??
                    "Clear"),
            height: 120,
            width: 130,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.weatherStore.weather?.list.first.main.temp
                        .toStringAsFixed(1) ??
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
                      "Feels Like: ${widget.weatherStore.weather?.list.first.main.feelsLike.toStringAsFixed(1)}˚",
                  fontSize: 13,
                  height: 0.12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Infos",
                  fontSize: 18,
                  height: 0.12,
                  fontWeight: FontWeight.w500,
                ),
                TextButton(
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
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomContainer(
                text: "Min",
                info:
                    "${widget.weatherStore.weather?.list.first.main.tempMin.toString()}˚",
              ),
              CustomContainer(
                text: "Max",
                info:
                    "${widget.weatherStore.weather?.list.first.main.tempMax.toString()}˚",
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomContainer(
                text: "Humidity",
                info:
                    "${widget.weatherStore.weather?.list.first.main.humidity.toString()}%",
              ),
              CustomContainer(
                text: "Wind",
                info:
                    "${widget.weatherStore.weather?.list.first.wind.speed.toString()} Km/h",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
