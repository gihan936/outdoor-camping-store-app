import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';
import '../widgets/custom_header.dart';
import '../widgets/product_card.dart';  // Import ProductCard to display products in the cart

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: CustomHeader(),
      backgroundColor: Color(0xFFFAF9F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(
              'Shopping Cart',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // Cart item list
          Expanded(
            child: cartItems.isEmpty
                ? Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(fontSize: 16),
              ),
            )
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Image.asset(
                      product.images[0],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text('${product.quantity} x \$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 14, color: Colors.green)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              product.shortDescription.length > 50
                                  ? '${product.shortDescription.substring(0, 50)}...'
                                  : product.shortDescription,
                              style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                if (product.quantity > 1) {
                                  cartProvider.updateQuantity(product, product.quantity - 1);
                                }
                              },
                            ),
                            Text('${product.quantity}'),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                cartProvider.updateQuantity(product, product.quantity + 1);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        cartProvider.removeFromCart(product);
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // Cart Summary Section
          if (cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SummaryRow(label: 'Subtotal', value: cartProvider.subtotal),
                  SummaryRow(label: 'Delivery Fee', value: cartProvider.deliveryFee),
                  SummaryRow(label: 'Tax (13%)', value: cartProvider.tax),
                  Divider(thickness: 1),
                  SummaryRow(label: 'Total', value: cartProvider.total, isTotal: true),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),  // Rounded corners
                      ),
                      backgroundColor: Colors.green,  // Button color
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/checkout',
                        arguments: cartProvider.total,  // Pass the total to the checkout screen
                      );
                    },
                    child: Text(
                      'Proceed to Checkout',
                      style: TextStyle(fontSize: 18, color: Colors.white),  // Text style
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isTotal;

  SummaryRow({required this.label, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('\$${value.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? Colors.blue : Colors.black)),
      ],
    );
  }
}
