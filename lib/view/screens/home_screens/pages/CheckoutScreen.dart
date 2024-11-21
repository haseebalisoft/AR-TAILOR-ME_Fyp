import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // State variables
  String selectedPaymentMethod = 'Cash on Delivery';
  TextEditingController phoneController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        backgroundColor: Color(0xff2a87ef), // Use blue color for app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Divider(thickness: 2),
                      buildSummaryItem('Cotton Fabric', 100.00),
                      buildSummaryItem('Silk Fabric', 150.00),
                      buildSummaryItem('Linen Shirt', 200.00),
                      buildSummaryItem('Wool Shirt', 250.00),
                      SizedBox(height: 10),
                      Divider(thickness: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$700.00',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Payment Method Section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Method',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Payment method options
                      RadioListTile<String>(
                        title: Row(
                          children: [
                            Icon(Icons.local_shipping, color: Color(0xff2a87ef)),
                            SizedBox(width: 10),
                            Text('Cash on Delivery'),
                          ],
                        ),
                        value: 'Cash on Delivery',
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Row(
                          children: [
                            Icon(Icons.account_balance_wallet, color: Color(0xff2a87ef)),
                            SizedBox(width: 10),
                            Text('JazzCash'),
                          ],
                        ),
                        value: 'JazzCash',
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value!;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      // Show additional fields if JazzCash is selected
                      if (selectedPaymentMethod == 'JazzCash') ...[
                        TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number for JazzCash',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 10),
                      ],
                      TextField(
                        controller: instructionsController,
                        decoration: InputDecoration(
                          labelText: 'Special Instructions for Delivery',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Pay Now Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _handlePayment();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2a87ef),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('PAY NOW', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build summary items
  Widget buildSummaryItem(String itemName, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemName,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Function to handle payment based on selected method
  void _handlePayment() {
    if (selectedPaymentMethod == 'Cash on Delivery') {
      // Handle Cash on Delivery
      _showPaymentConfirmation('Your order will be paid via Cash on Delivery.');
    } else if (selectedPaymentMethod == 'JazzCash') {
      // Handle JazzCash payment
      if (phoneController.text.isEmpty) {
        _showError('Please enter your phone number for JazzCash.');
      } else {
        _showPaymentConfirmation('Your order will be paid via JazzCash using phone number ${phoneController.text}.');
      }
    }
  }

  // Function to show payment confirmation dialog
  void _showPaymentConfirmation(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Confirmation'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Function to show error dialog
  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
