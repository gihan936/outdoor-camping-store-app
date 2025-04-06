import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);  // Get CartProvider instance
    bool isInCart = cartProvider.cartItems.any((item) => item.id == product.id);  // Check if product is in cart
    int cartQuantity = isInCart ? cartProvider.cartItems.firstWhere((item) => item.id == product.id).quantity : 0;  // Get quantity from the cart

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: product);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                product.images.first,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Product name
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

            // Product short description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.shortDescription.length > 50
                    ? product.shortDescription.substring(0, 50) + '...'
                    : product.shortDescription,
                style: TextStyle(color: Colors.grey[700], fontSize: 13),
              ),
            ),

            // Quantity control (display only if item is in the cart)
            if (isInCart)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline, color: Colors.green),
                      onPressed: () {
                        if (cartQuantity > 1) {
                          cartProvider.updateQuantity(product, cartQuantity - 1);
                        }
                      },
                    ),
                    Text('$cartQuantity'),
                    IconButton(
    icon: Icon(Icons.add_circle_outline, color: Colors.green),
                      onPressed: () {
                        if (cartQuantity < 10) {
                          cartProvider.updateQuantity(product, cartQuantity + 1);
                        }
                      },
                    ),
                  ],
                ),
              ),

            // If product is not in cart, show only + button
            if (!isInCart)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.green),
                  onPressed: () {
                    cartProvider.addToCart(product);  // Add to cart when + button is pressed
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
