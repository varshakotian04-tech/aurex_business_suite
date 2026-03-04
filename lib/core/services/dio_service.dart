import 'package:dio/dio.dart';
import '../resources/url_resources.dart';

class DioService {

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: UrlResources.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  )
  ..interceptors.add(
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ),
  );

}