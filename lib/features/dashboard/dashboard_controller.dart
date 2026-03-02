import 'package:get/get.dart';
import '../../core/services/auth_service.dart';

class DashboardController extends GetxController {
  final AuthService _auth = Get.find<AuthService>();

  final RxString userRole = "".obs;

  final RxInt salesCount = 0.obs;
  final RxDouble revenue = 0.0.obs;
  final RxInt activeUsers = 0.obs;
  final RxInt pendingTasks = 0.obs;

  final List<double> weeklySales = [
    20, 35, 28, 45, 60, 55, 70
  ];

  @override
  void onInit() {
    super.onInit();
    userRole.value = _auth.role.value;
    loadDashboard();
  }

  void loadDashboard() async {
    await Future.delayed(
        const Duration(milliseconds: 600));

    salesCount.value = 128;
    revenue.value = 54230.75;
    activeUsers.value = 24;
    pendingTasks.value = 7;
  }
}