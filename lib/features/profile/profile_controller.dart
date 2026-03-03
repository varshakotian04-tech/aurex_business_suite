import 'package:get/get.dart';
import '../../core/services/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService _auth = Get.find<AuthService>();

  String get role => _auth.role.value;

  void logout() {
    _auth.logout();
  }
}