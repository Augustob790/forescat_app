import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/const/api.dart';
import '../../domain/model/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getAllWeather(String cityName);
  Future<String> getCity();
}

class WeatherRepositoryImpl implements WeatherRepository {
  late Dio dio = Apis.dio;
  static String apiKey = dotenv.get('apiKey');
  @override
  Future<WeatherModel> getAllWeather(String cityName) async {
    String url = "?q=$cityName&appid=$apiKey&units=metric";
    try {
      final response = await dio.get(url);
      return WeatherModel.fromJson(response.data);
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
  Future<String> getCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placemarks[0].locality;
    return city ?? "";
  }
}
