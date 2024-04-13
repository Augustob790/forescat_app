// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:forecast_app/modules/data/repositories/weather_repository.dart';
import 'package:mobx/mobx.dart';
import '../../domain/model/weather_model.dart';

part 'weather_store.g.dart';

class WeatherStore = _WeatherStoreBase with _$WeatherStore;

abstract class _WeatherStoreBase with Store {
  final api = Modular.get<WeatherRepository>();

  String city = "";

  @observable
  WeatherModel? weather;

  @observable
  String? cityName;

  @observable
  dynamic errorMessage;

  @observable
  dynamic isLoading;

  @action
  Future<WeatherModel> getAllWeather(String cityName) async {
    isLoading = "isLoading";
    try {
      final response = await api.getAllWeather(cityName);
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
      final response = await api.getCity();
      city = response;
      return city;
    } catch (e) {
      log(e.toString());
      throw "$e";
    }
  }
}
