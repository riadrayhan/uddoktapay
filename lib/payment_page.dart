import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddoktapay/models/customer_model.dart';
import 'package:uddoktapay/models/request_response.dart';
import 'package:uddoktapay/uddoktapay.dart';

class UddoktapayPage extends StatefulWidget {
  const UddoktapayPage({super.key});

  @override
  State<UddoktapayPage> createState() => _UddoktapayPageState();
}

class _UddoktapayPageState extends State<UddoktapayPage> {
  Future<void> uddoktapay(BuildContext context) async {
    final response = await UddoktaPay.createPayment(
      context: context,
      customer: CustomerDetails(
        fullName: 'riad',
        email: 'riadrayhan111@gmail.com',
      ),
      amount: '100',
    );

    // Handle the response based on the status
    if (response.status == ResponseStatus.completed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Payment Completed, trx ID: ${response.transactionId} ${response.senderNumber}",
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else if (response.status == ResponseStatus.canceled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Payment Canceled..."),
          backgroundColor: Colors.red,
        ),
      );
    } else if (response.status == ResponseStatus.pending) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Payment Pending...\nPlease wait"),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Uddoktapay Payment"),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "Welcome to Uddoktapay",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Secure and fast payment system for all your needs.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Payment Button Section
            ElevatedButton.icon(
              onPressed: () async {
                await uddoktapay(context);
              },
              icon: const Icon(Icons.payment,color: Colors.black54,),
              label: const Text(
                "Make a Payment",
                style: TextStyle(fontSize: 18,color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: () async {
                // You can add more payment methods here if needed
                await uddoktapay(context);
              },
              icon: const Icon(Icons.attach_money,color: Colors.black45,),
              label: const Text(
                "Pay via Alternative Method",
                style: TextStyle(fontSize: 18,color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.teal[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const Spacer(),

            // Footer Section
            Container(
              alignment: Alignment.center,
              child: const Text(
                "Powered by Uddoktapay © 2024",
                style: TextStyle(color: Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
