import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_header.dart';
import '../providers/cart_provider.dart';

class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Camping Tent',
      shortDescription: '2-person waterproof tent',
      longDescription: 'Waterproof, easy setup, lightweight, durable for all conditions.',
      price: 120.00,
      images: [
        'assets/images/camper.jpg',
        'assets/images/camper2.jpg',
        'assets/images/camper3.jpg',
      ],
    ),
    Product(
      id: '2',
      name: 'Backpack',
      shortDescription: '2-person waterproof tent',
      longDescription: 'Waterproof, easy setup, lightweight, durable for all conditions.',
      price: 80.00,
      images: [
        'assets/images/sleeping_pad.jpg',
        'assets/images/sleeping_pad2.jpg',
      ],
    ),
    // More products...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(),
      backgroundColor: Color(0xFFFAF9F9),
      body: Column(
        children: [
          // Banner
          Image.asset(
            'assets/images/banner.jpg',
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),

          // Product Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 10, mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
