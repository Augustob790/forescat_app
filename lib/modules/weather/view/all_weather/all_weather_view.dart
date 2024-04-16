import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/const/image_constant.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/helpers/theme_helper.dart';
import '../../../../core/notifications/notifications_manager.dart';
import '../../../../core/widgets/get_error_ui.dart';
import '../../../../core/widgets/load_ui.dart';
import 'widgets/custom_appbar.dart';
import 'widgets/custom_container_all.dart';
import '../../../../core/widgets/custom_text.dart';

import '../../presentation/store/weather_store.dart';
import 'widgets/custom_container.dart';

class AllWeatherView extends StatefulWidget {
  const AllWeatherView({
    super.key,
    required this.weatherStore,
  });

  final WeatherStore weatherStore;

  @override
  State<AllWeatherView> createState() => _AllWeatherViewState();
}

class _AllWeatherViewState extends State<AllWeatherView> {
  inicialize() async {
    await widget.weatherStore.getCurrentCity();
    await widget.weatherStore.getAllWeather(widget.weatherStore.city);
    NotificationsManager().showNotification(title: "Atualização", body: "Previsão do tempo atualizada!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarAll(
        onPressed: () async {
          inicialize();
        },
      ),
      body: Observer(
        builder: (context) {
          if (widget.weatherStore.isLoading == "isLoading") {
            return const LoadUi();
          } else if (widget.weatherStore.errorMessage == "error") {
            return const GetErrorUi(error: "Error");
          } else if (widget.weatherStore.weather != null &&
              widget.weatherStore.isLoading == "sucess") {
            return getBodyUI();
          } else {
            return const LoadUi();
          }
        },
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
          Container(
            margin: const EdgeInsets.all(20),
            child: CustomText(
              text: Helpers.convertToWeekday(
                  widget.weatherStore.forecast!.list.first.date),
              fontSize: 18.35,
              height: 0.08,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomContainer(list: widget.weatherStore.forecast!.list),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 30),
                itemCount: widget.weatherStore.forecast?.list.length,
                itemBuilder: (context, index) {
                  final asx = widget.weatherStore.forecast?.list[index];
                  return CustomContainerAll(
                    weekDay: Helpers.convertToWeekday(asx?.date ?? ""),
                    imageWeather: asx?.weather.first.main ?? "c",
                    max: "${asx?.main.tempMax.toStringAsFixed(1)}˚",
                    min: "${asx?.main.tempMin.toStringAsFixed(1)}˚",
                  );
                }),
          ),
        ],
      ),
    );
  }
}
