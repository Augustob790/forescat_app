// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WeatherStore on _WeatherStoreBase, Store {
  final _$forecastAtom = Atom(name: '_WeatherStoreBase.forecast');

  @override
  WeatherForecast? get forecast {
    _$forecastAtom.reportRead();
    return super.forecast;
  }

  @override
  set forecast(WeatherForecast? value) {
    _$forecastAtom.reportWrite(value, super.forecast, () {
      super.forecast = value;
    });
  }

  final _$weatherAtom = Atom(name: '_WeatherStoreBase.weather');

  @override
  WeatherModel? get weather {
    _$weatherAtom.reportRead();
    return super.weather;
  }

  @override
  set weather(WeatherModel? value) {
    _$weatherAtom.reportWrite(value, super.weather, () {
      super.weather = value;
    });
  }

  final _$cityNameAtom = Atom(name: '_WeatherStoreBase.cityName');

  @override
  String? get cityName {
    _$cityNameAtom.reportRead();
    return super.cityName;
  }

  @override
  set cityName(String? value) {
    _$cityNameAtom.reportWrite(value, super.cityName, () {
      super.cityName = value;
    });
  }

  final _$getAllWeatherAction = AsyncAction('_WeatherStoreBase.getAllWeather');

  @override
  Future<WeatherForecast> getAllWeather(String cityName) {
    return _$getAllWeatherAction.run(() => super.getAllWeather(cityName));
  }

  final _$getCityWeatherAction =
      AsyncAction('_WeatherStoreBase.getCityWeather');

  @override
  Future<WeatherModel> getCityWeather(String name) {
    return _$getCityWeatherAction.run(() => super.getCityWeather(name));
  }

  final _$getCurrentCity = AsyncAction('_WeatherStoreBase.getCurrentCity');

  @override
  Future<String> getCurrentCity() {
    return _$getCurrentCity.run(() => super.getCurrentCity());
  }

  final _$errorMessageAtom = Atom(name: '_WeatherStoreBase.errorMessage');

  @override
  dynamic get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(dynamic value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_WeatherStoreBase.isLoading');

  @override
  dynamic get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(dynamic value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
errorMessage: ${errorMessage}
weather: ${weather}
cityName: ${cityName}
    ''';
  }
}
