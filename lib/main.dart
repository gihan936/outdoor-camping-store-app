import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/cart_screen.dart';
import 'models/product.dart';
import 'providers/cart_provider.dart';


void main() {
  runApp(CampingStoreApp());
}

class CampingStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Camping Store',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Roboto',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/products': (context) => ProductListScreen(),
          '/checkout': (context) => CheckoutScreen(),
          '/cart': (context) => CartScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/detail') {
            final product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            );
          }
          return null;
        },
      ),
    );
  }
}
