import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/const/api.dart';
import '../../domain/model/weather_forecast_model.dart';

abstract class WeatherRepository {
  Future<WeatherForecast> getCityWeather(Position position);
  Future<WeatherForecast> getAllWeather(Position position);
  Future<Position> getPosition();
}

class WeatherRepositoryImpl implements WeatherRepository {
  late Dio dio = Apis.dio;
  static String apiKey = dotenv.get('apiKey');

  @override
  Future<WeatherForecast> getAllWeather(Position position) async {
    String url = "forecast?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric";
    try {
      final response = await dio.get(url);
      return WeatherForecast.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw "Por favor, verifique sua conexão e tente novamente.";
      } else if (e.type == DioExceptionType.connectionError) {
        throw "Erro de conexão: $e";
      } else {
        throw e.toString();
      }
    } catch (e) {
      throw Exception("Error get all weather: $e");
    }
  }

  @override
  Future<WeatherForecast> getCityWeather(Position position) async {
    String url = "forecast?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric&cnt=1";
    try {
      final response = await dio.get(url);
      return WeatherForecast.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw "Por favor, verifique sua conexão e tente novamente.";
      } else if (e.type == DioExceptionType.connectionError) {
        throw "Erro de conexão: $e";
      } else {
        throw e.toString();
      }
    } catch (e) {
      throw Exception("Error get all weather: $e");
    }
  }

  @override
  Future<Position> getPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      throw e.toString();
    }
  }
}
