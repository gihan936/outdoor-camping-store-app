import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/custom_header.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;  // Initialize quantity as 1
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final cartProvider = Provider.of<CartProvider>(context);

    // Check if product is in the cart and set its quantity
    final cartProduct = cartProvider.cartItems.firstWhere(
          (item) => item.id == product.id,
      orElse: () => Product(id: '', name: '', price: 0, shortDescription: '', longDescription: '', images: []),
    );
    bool isInCart = cartProduct.id != ''; // Check if the product is in the cart

    if (isInCart) {
      _quantity = cartProduct.quantity;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Adjust height as needed
        child: CustomHeader(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                product.name,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
              ),
            ),

            // Image Swiper
            SizedBox(
              height: 250,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    itemCount: product.images.length,
                    onPageChanged: (index) {
                      setState(() => _currentImageIndex = index);
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(product.images[index], fit: BoxFit.cover, width: double.infinity);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(product.images.length, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                        height: 8,
                        width: _currentImageIndex == index ? 20 : 8,
                        decoration: BoxDecoration(
                          color: _currentImageIndex == index ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Product Info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Short description
                  Text(
                    product.shortDescription,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  // Long description
                  Text(
                    product.longDescription,
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  SizedBox(height: 16),

                  // Quantity Control
                  if (isInCart)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Quantity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline, color: Colors.green),
                                onPressed: () {
                                  if (_quantity > 1) {
                                    setState(() => _quantity--);
                                    cartProvider.updateQuantity(product, _quantity);
                                  }
                                },
                              ),
                              Text('$_quantity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: Icon(Icons.add_circle_outline, color: Colors.green),
                                onPressed: () {
                                  if (_quantity < 10) {
                                    setState(() => _quantity++);
                                    cartProvider.updateQuantity(product, _quantity);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (!isInCart)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            cartProvider.addToCart(product);
                            setState(() {
                              _quantity = 1; // Reset quantity to 1 after adding to cart
                            });
                          },
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
