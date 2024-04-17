// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/notifications/notifications_manager.dart';
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


  @observable
  WeatherForecast? forecast;

  @observable
  WeatherForecast? weather;

  @observable
  Position? position;

  @observable
  dynamic errorMessage;

  @observable
  dynamic isLoading;

  @action
  Future<WeatherForecast> getAllWeather(Position position) async {
    isLoading = "isLoading";
    try {
      final response = await getAllWeatherUsecase(position);
      forecast = response;
      isLoading = "sucess";
      return forecast!;
    } catch (e) {
      isLoading = "error";
      throw e.toString();
    }
  }

  @action
  checkWeatherForecastUpdates() async {
    final preferences = await SharedPreferences.getInstance();
    final String? storedWeather = preferences.getString('storedWeathers');
    final String newWeather = weather!.list.first.main.temp.toString();
    if (storedWeather != newWeather) {
      NotificationsManager().showNotification(
          title: "Atualização", body: "Houve mudanças no clima/tempo!");
      await preferences.setString('storedWeather', newWeather);
    }
  }

  @action
  Future<WeatherForecast> getCityWeather(Position position) async {
    isLoading = "isLoading";
    try {
      final response = await getCityWeatherUsecase(position);
      isLoading = "sucess";
      weather = response;
      checkWeatherForecastUpdates();
      return weather!;
    } catch (e) {
      isLoading = "error";
      errorMessage = e.toString();
      log(e.toString());
      throw "$e";
    }
  }

  @action
  Future<Position> getPosition() async {
    isLoading = "isLoading";
    try {
      final response = await getCurrentCityUsecase();
      isLoading = "sucess";
      position = response;
      return position!;
    } catch (e) {
      isLoading = "error";
      errorMessage = e.toString();
      log(e.toString());
      throw "$e";
    }
  }
}
