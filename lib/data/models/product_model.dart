class ProductModel {
  final int id;
  final String title;
  final int stock;
  final double price;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      stock: json['stock'],
      price: (json['price'] as num).toDouble(),
    );
  }
}