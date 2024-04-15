import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/const/app_decoration.dart';
import '../../core/helpers/helpers.dart';
import '../../core/helpers/theme_helper.dart';
import '../../core/widgets/custom_container_all.dart';
import '../../core/widgets/custom_image_view.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/get_error_ui.dart';
import '../../core/widgets/load_ui.dart';
import '../presentation/store/weather_store.dart';

class AllWeatherView extends StatefulWidget {
  const AllWeatherView({
    super.key,
  });

  @override
  State<AllWeatherView> createState() => _AllWeatherViewState();
}

class _AllWeatherViewState extends State<AllWeatherView> {
  late final WeatherStore weatherStore;

  @override
  void initState() {
    super.initState();
    weatherStore = Modular.get<WeatherStore>();
    //inicialize();
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
        title: const Text(
          'Proximos 5 dias',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: const EdgeInsets.all(0),
          icon: const SizedBox(
            width: 40,
            height: 40,
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Observer(
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
              appTheme.blueGray900
            ]),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 150, bottom: 20),
            child: CustomText(
              text: Helpers.weekdayNameView,
              fontSize: 18.35,
              height: 0.08,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: AppDecoration.gradientDeepPurpleToBlueGray
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomImageView(
                    imagePath: Helpers.imageClima(
                        weatherStore.weather?.weather.first.main ?? "Clear"),
                    height: 132,
                    width: 140,
                  ),
                  Text(
                    "${weatherStore.weather?.main.temp.toStringAsFixed(1)}˚",
                    style: theme.textTheme.displayLarge,
                  ),
                ]),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 30),
                itemCount: weatherStore.forecast?.list.length,
                itemBuilder: (context, index) {
                  final asx = weatherStore.forecast?.list[index];
                  return CustomContainerAll(
                    weekDay: Helpers.convertToWeekday(asx?.date ?? ""),
                    imageWeather: asx!.weather.first.main,
                    max: "${asx.main.tempMax.toStringAsFixed(1)}˚",
                    min: "${asx.main.tempMax.toStringAsFixed(1)}˚",
                  );
                }),
          ),
        ],
      ),
    );
  }
}
