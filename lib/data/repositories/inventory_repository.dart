import 'package:dio/dio.dart';

import '../../core/services/dio_service.dart';
import '../models/product_model.dart';

class InventoryRepository {
  final Dio _dio = DioService().dio;

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response =
          await _dio.get("https://dummyjson.com/products");

      final List products = response.data["products"];

      return products
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to load products",
      );
    }
  }
}