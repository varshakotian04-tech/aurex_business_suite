import 'dart:async';
import 'package:get/get.dart';
import '../../core/services/storage_service.dart';
import '../../core/resources/constants.dart';
import '../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  final StorageService storageService = StorageService();

  @override
  void onInit() {
    super.onInit();
    startApp();
  }

  void startApp() async {
    await Future.delayed(const Duration(seconds: 2));

    final token =
        await storageService.readData(AppConstants.tokenKey);

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}