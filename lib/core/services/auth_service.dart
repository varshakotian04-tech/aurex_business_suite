import 'package:get/get.dart';
import 'storage_service.dart';
import '../resources/constants.dart';

class AuthService extends GetxService {
  final StorageService _storage = StorageService();

  final RxString role = "Staff".obs;

  Future<AuthService> init() async {
    final savedRole =
        await _storage.readData(AppConstants.roleKey);

    if (savedRole != null && savedRole.isNotEmpty) {
      role.value = savedRole;
    }

    return this;
  }

  bool get isAdmin => role.value == "Admin";
  bool get isManager => role.value == "Manager";
  bool get isStaff => role.value == "Staff";
}