import 'package:flutter/material.dart';
import '../widgets/custom_header.dart';

class CheckoutScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final RegExp _canadianPhoneReg = RegExp(r'^\d{3}-\d{3}-\d{4}$');
  final RegExp _canadianPostalReg = RegExp(r'^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$');
  final RegExp _expiryReg = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
  final RegExp _cardNumberReg = RegExp(r'^\d{16}$');
  final RegExp _cvvReg = RegExp(r'^\d{3}$');

  @override
  Widget build(BuildContext context) {
    final totalAmount = ModalRoute.of(context)!.settings.arguments as double;

    return Scaffold(
      appBar: CustomHeader(),
      backgroundColor: Color(0xFFF9F9F9),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              'Checkout',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Total: \$${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            _buildSectionTitle('Delivery Details'),
            _buildInputCard([
              _buildTextField('Full Name'),
              _buildTextField('Mobile Number (e.g. 123-456-7890)',
                  validator: (v) =>
                  !_canadianPhoneReg.hasMatch(v!) ? 'Invalid phone number' : null),
              _buildTextField('House Number'),
              _buildTextField('Street Name'),
              _buildTextField('City'),
              _buildTextField('Postal Code (e.g. A1A 1A1)',
                  validator: (v) =>
                  !_canadianPostalReg.hasMatch(v!) ? 'Invalid postal code' : null),
            ]),

            SizedBox(height: 24),
            _buildSectionTitle('Payment Information'),
            _buildInputCard([
              _buildTextField('Name on Card'),
              _buildTextField('Card Number',
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                  !_cardNumberReg.hasMatch(v!) ? 'Invalid card number' : null),
              _buildTextField('Expiry (MM/YY)',
                  validator: (v) =>
                  !_expiryReg.hasMatch(v!) ? 'Invalid expiry format' : null),
              _buildTextField('CVV',
                  keyboardType: TextInputType.number,
                  validator: (v) => !_cvvReg.hasMatch(v!) ? 'Invalid CVV' : null),
            ]),

            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                backgroundColor: Colors.green,
              ),
              child: Text(
                'Place Order',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Order placed successfully!')),
                  );
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInputCard(List<Widget> children) {
    return Card(
      elevation: 3,
      shadowColor: Colors.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: children
              .map((child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: child,
          ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildTextField(String label,
      {TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide.none),
      ),
      validator: validator ?? (value) => value!.isEmpty ? 'Required field' : null,
    );
  }
}
