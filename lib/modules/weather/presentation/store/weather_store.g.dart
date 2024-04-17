// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WeatherStore on _WeatherStoreBase, Store {
  late final _$forecastAtom =
      Atom(name: '_WeatherStoreBase.forecast', context: context);

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

  late final _$weatherAtom =
      Atom(name: '_WeatherStoreBase.weather', context: context);

  @override
  WeatherForecast? get weather {
    _$weatherAtom.reportRead();
    return super.weather;
  }

  @override
  set weather(WeatherForecast? value) {
    _$weatherAtom.reportWrite(value, super.weather, () {
      super.weather = value;
    });
  }

  late final _$cityNameAtom =
      Atom(name: '_WeatherStoreBase.cityName', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: '_WeatherStoreBase.errorMessage', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: '_WeatherStoreBase.isLoading', context: context);

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

  late final _$getAllWeatherAsyncAction =
      AsyncAction('_WeatherStoreBase.getAllWeather', context: context);

  @override
  Future<WeatherForecast> getAllWeather(String cityName) {
    return _$getAllWeatherAsyncAction.run(() => super.getAllWeather(cityName));
  }

  late final _$checkWeatherForecastUpdatesAsyncAction = AsyncAction(
      '_WeatherStoreBase.checkWeatherForecastUpdates',
      context: context);

  @override
  Future checkWeatherForecastUpdates() {
    return _$checkWeatherForecastUpdatesAsyncAction
        .run(() => super.checkWeatherForecastUpdates());
  }

  late final _$getCityWeatherAsyncAction =
      AsyncAction('_WeatherStoreBase.getCityWeather', context: context);

  @override
  Future<WeatherForecast> getCityWeather(String cityName) {
    return _$getCityWeatherAsyncAction
        .run(() => super.getCityWeather(cityName));
  }

  late final _$getCurrentCityAsyncAction =
      AsyncAction('_WeatherStoreBase.getCurrentCity', context: context);

  @override
  Future<String> getCurrentCity() {
    return _$getCurrentCityAsyncAction.run(() => super.getCurrentCity());
  }

  @override
  String toString() {
    return '''
forecast: ${forecast},
weather: ${weather},
cityName: ${cityName},
errorMessage: ${errorMessage},
isLoading: ${isLoading}
    ''';
  }
}
