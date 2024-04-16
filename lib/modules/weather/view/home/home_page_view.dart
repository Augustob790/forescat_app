// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../core/const/image_constant.dart';
import '../../../auth/presentation/auth_store.dart';
import '../../../auth/services/firebase_services.dart';
import 'widget/custom_container.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/get_error_ui.dart';
import '../../../../core/widgets/load_ui.dart';
import '../../presentation/store/weather_store.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/helpers/theme_helper.dart';

class HomePageView extends StatefulWidget {
  const HomePageView(
      {super.key, required this.weatherStore, required this.authStore});

  final WeatherStore weatherStore;
  final AuthStore authStore;

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

final service = Modular.get<FirebaseAuthService>();

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
    inicialize();
  }

  inicialize() async {
    await widget.weatherStore.getCurrentCity();
    await widget.weatherStore.getCityWeather(widget.weatherStore.city);
    await widget.weatherStore.getAllWeather(widget.weatherStore.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.5, 0.5),
              end: const Alignment(0.5, 2.5),
              colors: [appTheme.indigo900, appTheme.blueGray700],
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Cor do ícone
        ),
        elevation: 0,
        title: Observer(builder: (context) {
          return CustomText(
            text: widget.weatherStore.weather?.city.name ?? "",
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
      drawer: Drawer(
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
                    backgroundImage: NetworkImage(
                        widget.authStore.userModel?.photoImage == null
                            ? service.usuario?.photoURL ?? ""
                            : widget.authStore.userModel?.photoImage ?? ""),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.authStore.userModel?.email == null
                        ? service.usuario?.email ?? ""
                        : "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              trailing: IconButton(
                onPressed: () {
                  widget.authStore.logout();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
              ),
              title: Text('Sair'),
              onTap: () {
                // Implemente a ação de sair
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Observer(
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
          CustomText(
            text: widget.authStore.userModel?.email ?? "",
            fontSize: 18.35,
            height: 0.08,
            color: Colors.black,
            fontWeight: FontWeight.w600,
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
