import 'package:get/get.dart';
import '../../data/models/order_model.dart';
import '../../data/repositories/orders_repository.dart';

class OrdersController extends GetxController {
  final OrdersRepository repository =
      OrdersRepository();

  final RxList<OrderModel> orders =
      <OrderModel>[].obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final result =
          await repository.fetchOrders();

      orders.value = result;
    } catch (e) {
      errorMessage.value =
          e.toString().replaceAll("Exception: ", "");
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> createOrder() async {
  try {
    isLoading.value = true;
    errorMessage.value = "";

    final newOrder =
        await repository.createOrder();

    orders.insert(0, newOrder);
  } catch (e) {
    errorMessage.value =
        e.toString().replaceAll("Exception: ", "");
  } finally {
    isLoading.value = false;
  }
}
}