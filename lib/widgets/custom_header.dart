import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: GestureDetector(
        onTap: () {
          // Navigate to the Product List screen when logo is tapped
          Navigator.pushNamed(context, '/products');
        },
        child: Image.asset(
          'assets/images/logotext.png',
          height: 40,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () {
              // Navigate to the Cart screen when the cart button is tapped
              Navigator.pushNamed(context, '/cart');
            },
            child: Image.asset(
              'assets/images/cartbutton.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
