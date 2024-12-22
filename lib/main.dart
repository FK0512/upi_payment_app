import 'package:flutter/material.dart';
import 'package:upi_pay/upi_pay.dart';

void main() {
  runApp(UPIPaymentApp());
}

class UPIPaymentApp extends StatelessWidget {
  const UPIPaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UpiPaymentScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UpiPaymentScreen extends StatefulWidget {
  const UpiPaymentScreen({super.key});

  @override
  _UpiPaymentScreenState createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  final _upiIdController = TextEditingController();
  final _amountController = TextEditingController();

  Future<void> _initiateTransaction() async {
    String upiId = _upiIdController.text.trim();
    String amount = _amountController.text.trim();

    if (upiId.isEmpty || amount.isEmpty) {
      _showMessage("Please enter both UPI ID and amount.");
      return;
    }

    if (double.tryParse(amount) == null || double.parse(amount) <= 0) {
      _showMessage("Please enter a valid amount.");
      return;
    }

    try {
      final transaction = await UpiPay.initiateTransaction(
        app: UpiApplication.googlePay, // Example UPI app
        receiverUpiAddress: upiId,
        receiverName: "Test Receiver",
        transactionRef: "TestTransaction123",
        transactionNote: "Payment for testing",
        amount: amount,
      );

      _showMessage("Transaction Status: ${transaction.status}");
    } catch (e) {
      _showMessage("Transaction failed: $e");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPI Payment App'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _upiIdController,
              decoration: InputDecoration(
                labelText: "Enter Receiver UPI ID",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: "Enter Amount (INR)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _initiateTransaction,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text("Pay Now"),
            ),
          ],
        ),
      ),
    );
  }
}
