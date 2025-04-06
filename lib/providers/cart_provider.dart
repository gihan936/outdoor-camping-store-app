import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    final existingProductIndex = _cartItems.indexWhere((item) => item.id == product.id);
    if (existingProductIndex != -1) {
      if (_cartItems[existingProductIndex].quantity < 10) {
        _cartItems[existingProductIndex].quantity += product.quantity;
      }
    } else {
      _cartItems.add(product);
    }
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    final productIndex = _cartItems.indexWhere((item) => item.id == product.id);
    if (productIndex != -1) {
      if (quantity <= 10) {
        _cartItems[productIndex].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

  // Getters for subtotal, delivery fee, tax, and total
  double get subtotal {
    return _cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get deliveryFee {
    return 50.0;  // You can change this value
  }

  double get tax {
    return subtotal * 0.13;  // 13% tax
  }

  double get total {
    return subtotal + deliveryFee + tax;
  }
}
