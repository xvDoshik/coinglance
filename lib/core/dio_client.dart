import 'package:dio/dio.dart';

Dio createDio() {
  return Dio(
    BaseOptions(
      baseUrl: 'https://api.coingecko.com/api/v3',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );
}
