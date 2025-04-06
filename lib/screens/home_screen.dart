import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/camper.jpg', height: 120),
            SizedBox(height: 20),
            Text(
              'Welcome to CampLife',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Your outdoor adventure starts here.'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/products'),
              child: Text('Browse Products'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
