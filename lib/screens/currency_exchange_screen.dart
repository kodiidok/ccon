import 'package:ccon/widgets/currency_input.dart'; // Update path if necessary
import 'package:flutter/material.dart';

class CurrencyExchangeScreen extends StatelessWidget {
  const CurrencyExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Exchange Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'INSERT AMOUNT',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const CurrencyInputWidget(),
            const SizedBox(height: 20),
            const Text(
              'CONVERT TO',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Button action goes here
              },
              child: const Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }
}
