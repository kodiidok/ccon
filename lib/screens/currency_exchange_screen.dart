import 'package:flutter/material.dart';
import 'package:ccon/widgets/currency_widget.dart'; // Update the path as needed

class CurrencyExchangeScreen extends StatelessWidget {
  const CurrencyExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Exchange Screen'),
      ),
      body: const CurrencyWidget(),
    );
  }
}
