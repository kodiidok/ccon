
import 'package:ccon/widgets/amount_input.dart';
import 'package:ccon/widgets/currency_selector.dart';
import 'package:flutter/material.dart';

class CurrencyInputWidget extends StatelessWidget {
  const CurrencyInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Set your desired background color here
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0), // Adjust horizontal padding
      height: 60, // Set a fixed height for the container
      child: const Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center content horizontally
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align content vertically
        children: [
          // Text input field to enter currency code
          Expanded(
            child: AmountInputWidget(),
          ),
          SizedBox(width: 8), // Reduce spacing between widgets
          // Dropdown button to select currency
          CurrencySelectorWidget(),
        ],
      ),
    );
  }
}
