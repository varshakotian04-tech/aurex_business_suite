class UrlResources {
  /// Base URL
  static const String baseUrl = "https://dummyjson.com";

  /// Auth
  /// https://dummyjson.com/auth/login
  static const String login = "/auth/login";

  /// Products / Inventory
  /// https://dummyjson.com/products
  static const String products = "/products";
  ///https://dummyjson.com/products/1
  static const String productById = "/products"; 
  // Usage: /products/{id}

  /// Orders (Dummy placeholder for now)
  /// GET https://dummyjson.com/carts
  static const String carts = "/carts";
  static const String addCart = "/carts/add";

  /// Users 
  /// https://dummyjson.com/users
  static const String users = "/users";
}