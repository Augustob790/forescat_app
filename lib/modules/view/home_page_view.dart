import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/const/image_constant.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/get_error_ui.dart';
import '../../core/widgets/load_ui.dart';
import '../presentation/store/weather_store.dart';
import '../../core/widgets/custom_image_view.dart';
import '../../core/helpers/helpers.dart';
import '../../core/helpers/theme_helper.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late final WeatherStore weatherStore;
  String city = " ";

  @override
  void initState() {
    super.initState();
    weatherStore = Modular.get<WeatherStore>();
    inicialize();
  }

  inicialize() async {
    await weatherStore.getCurrentCity();
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
        title: CustomText(
          text: weatherStore.weather?.cityName ?? "",
          color: Colors.white,
          fontSize: 18,
          height: 0.10,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Observer(
          name: "inital",
          builder: (context) {
            if (weatherStore.isLoading == "isLoading") {
              return const LoadUi();
            } else if (weatherStore.errorMessage == "error") {
              return const GetErrorUi(error: "Error");
            } else if (weatherStore.weather != null &&
                weatherStore.isLoading == "sucess") {
              return getBodyUI();
            } else {
              return const GetErrorUi(error: "Error");
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
              imagePath: Helpers.imageClima("Sol"),
              height: 122,
              width: 130,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weatherStore.weather?.temp.toStringAsFixed(1) ?? "",
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomText(
              text: Helpers.dateForBR,
              fontSize: 13,
              height: 0.12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          // const Row(
          //   children: [
          //     Padding(
          //       padding: EdgeInsets.only(left: 15),
          //       child: SizedBox(
          //         width: 34,
          //         child: Text(
          //           'Hoje',
          //           style: TextStyle(
          //             color: Color(0xFFDEDDDD),
          //             fontSize: 12,
          //             fontFamily: 'Poppins',
          //             fontWeight: FontWeight.w600,
          //             height: 0.12,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // InkWell(
              //   onTap: () => {},
              //   child: Padding(
              //     padding: const EdgeInsets.all(7.0),
              //     child: CustomContainer(
              //       horario: "Manhã",
              //       image: Helpers.imageClima("sol"),
              //       grau: "graus",
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () => {},
              //   child: Padding(
              //     padding: const EdgeInsets.all(7.0),
              //     child: CustomContainer(
              //       horario: "Tarde",
              //       image: Helpers.imageClima(provider.tarde.first.tempo ?? ''),
              //       grau: provider.tarde.first.graus,
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () => {},
              //   child: Padding(
              //     padding: const EdgeInsets.all(7.0),
              //     child: CustomContainer(
              //       horario: "Noite",
              //       image: Helpers.imageClima(provider.noite.first.tempo ?? ''),
              //       grau: provider.noite.first.graus,
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          // ignore: prefer_const_constructors
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Estados',
                  style: TextStyle(
                    color: Color(0xFFDEDDDD),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0.12,
                  ),
                ),
              ),
            ],
          ),
          // Expanded(
          //   child: Consumer<DetailsScreenController>(
          //     builder: (context, info, child) => ListView.builder(
          //         scrollDirection: Axis.horizontal,
          //         itemCount: info.states.length,
          //         itemBuilder: (context, index) => CustomListView(
          //               image: info.weather,
          //               estado: info.states[index].estado,
          //               graus: info.grausState,
          //             )),
          //   ),
          // ),
        ],
      ),
    );
  }
}
