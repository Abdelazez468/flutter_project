import 'package:flutter/material.dart';

class Product {
  int id;
  String name;
  double price;
  bool isInCart;
  IconData icon;
  int quantity = 1;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.isInCart = false,
    required this.icon,
    this.quantity = 1,
  });
}

class ShoppingProvider extends ChangeNotifier {
  List<Product> products = [
    Product(id: 1, name: "Phone", price: 5000, icon: Icons.phone),

    Product(id: 2, name: "Laptop", price: 5000, icon: Icons.laptop),

    Product(id: 3, name: "Headphones", price: 5000, icon: Icons.headphones),

    Product(id: 4, name: "Keyboard", price: 46, icon: Icons.keyboard),

    Product(id: 5, name: "Mouse", price: 400, icon: Icons.mouse),

    Product(id: 6, name: "Watch", price: 80, icon: Icons.watch),

    Product(id: 7, name: "Phone", price: 2000, icon: Icons.phone),

    Product(id: 8, name: "Laptop", price: 5000, icon: Icons.laptop),

    Product(id: 9, name: "Headphones", price: 900, icon: Icons.headphones),

    Product(id: 10, name: "Keyboard", price: 5000, icon: Icons.keyboard),

    Product(id: 11, name: "Mouse", price: 400, icon: Icons.mouse),

    Product(id: 12, name: "Watch", price: 5000, icon: Icons.watch),
  ];

  void Change_Item_Status(int id) {
    Product product = products.firstWhere((item) => item.id == id);

    product.isInCart = !product.isInCart;
    notifyListeners();
  }

  int get cartCount {
    return products.where((item) => item.isInCart).length;
  }

  void increaseQuantity(int id) {
    var product = products.firstWhere((p) => p.id == id);

    product.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(int id) {
    var product = products.firstWhere((p) => p.id == id);

    if (product.quantity > 1) {
      product.quantity--;
      notifyListeners();
    }
  }

  int get totalPrice {
    int total = 0;

    for (var product in products) {
      if (product.isInCart) {
        total += (product.price * product.quantity).toInt();
      }
    }

    return total;
  }

  void Clear() {
    for (var product in products) {
      product.isInCart = false;
      product.quantity = 1;
    }

    notifyListeners();
  }
}
