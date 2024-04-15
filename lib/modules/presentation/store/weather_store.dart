// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';
import 'package:mobx/mobx.dart';
import '../../domain/model/weather_forecast_model.dart';
import '../../domain/usecases/get_all_weather_use_cases.dart';
import '../../domain/usecases/get_city_use_cases.dart';
import '../../domain/usecases/get_current_city_use_cases.dart';

part 'weather_store.g.dart';

class WeatherStore = _WeatherStoreBase with _$WeatherStore;

abstract class _WeatherStoreBase with Store {
  final GetAllWeatherUsecase getAllWeatherUsecase;
  final GetCityWeatherUsecase getCityWeatherUsecase;
  final GetCurrentCityUsecase getCurrentCityUsecase;

  _WeatherStoreBase({
    required this.getAllWeatherUsecase,
    required this.getCityWeatherUsecase,
    required this.getCurrentCityUsecase,
  });

  String city = "";

  @observable
  WeatherForecast? forecast;

  @observable
  WeatherForecast? weather;

  @observable
  String? cityName;

  @observable
  dynamic errorMessage;

  @observable
  dynamic isLoading;

  @action
  Future<WeatherForecast> getAllWeather(String cityName) async {
    isLoading = "isLoading";
    try {
      final response = await getAllWeatherUsecase(cityName);
      forecast = response;
      isLoading = "sucess";
      return forecast!;
    } catch (e) {
      isLoading = "error";
      throw e.toString();
    }
  }

  @action
  Future<WeatherForecast> getCityWeather(String cityName) async {
    isLoading = "isLoading";
    try {
      final response = await getCityWeatherUsecase(cityName);
      isLoading = "sucess";
      weather = response;
      return weather!;
    } catch (e) {
      isLoading = "error";
      errorMessage = e.toString();
      log(e.toString());
      throw "$e";
    }
  }

  @action
  Future<String> getCurrentCity() async {
    try {
      final response = await getCurrentCityUsecase();
      city = response;
      return city;
    } catch (e) {
      log(e.toString());
      throw "$e";
    }
  }
}
