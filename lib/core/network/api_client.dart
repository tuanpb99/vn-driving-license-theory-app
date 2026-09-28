import 'package:dio/dio.dart';

class ApiClient {
  ApiClient._();

  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000',
  );

  static Dio createDio() {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 10),
        headers: const {'Content-Type': 'application/json'},
      ),
    )..interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: false,
        ),
      );
  }
}
