import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/inventory_repository.dart';

class InventoryController extends GetxController {
  final InventoryRepository _repository =
      InventoryRepository();

  final RxList<ProductModel> products =
      <ProductModel>[].obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = "".obs;
  final RxString searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final result =
          await _repository.fetchProducts();

      products.value = result;
    } catch (e) {
      errorMessage.value =
          e.toString().replaceAll("Exception: ", "");
    } finally {
      isLoading.value = false;
    }
  }

  List<ProductModel> get filteredProducts {
    if (searchQuery.value.isEmpty) return products;

    return products
        .where((p) => p.title
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase()))
        .toList();
  }
}