import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Apis {
  Apis._internal();
  static String baseUrl = dotenv.get('baseUrl');
  static String apiKey = dotenv.get('apiKey');
  static int statusCodeSuccess = 200;
  static int statusCodeCreated = 201;

  static final dio = Dio();
  static final Apis _apis = Apis._internal();

  factory Apis() {
    dio.options.baseUrl = baseUrl;
    // dio.options.headers['apikey'] = apiKey;
    // dio.options.headers['Authorization'] = 'Bearer $apiKey';
    // dio.options.headers['Content-Type'] = 'application/json';
    // dio.options.headers['Prefer'] = 'return=minimal';
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 15);
    addInterceptor();
    return _apis;
  }

  static void addInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
        },
      ),
    );
  }
}
