import 'package:dio/dio.dart';
import '../../core/services/dio_service.dart';
import '../../core/resources/url_resources.dart';
import '../models/user_model.dart';

class AuthRepository {

  final Dio dio = DioService().dio;

  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {

      final response = await dio.post(
        UrlResources.login,
        data: {
          "username": username,
          "password": password,
          "expiresInMins": 30,
        },
      );

      /// Success response
      return UserModel.fromJson(response.data);

    } on DioException catch (e) {

      /// Extract API error message
      final message =
          e.response?.data["message"] ?? "Login failed";

      throw Exception(message);
    }
  }
}