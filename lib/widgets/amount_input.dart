import 'package:ccon/widgets/global_currency_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/blocs/amount_cubit.dart';
import 'package:ccon/blocs/currency_cubit.dart'; // Import the CurrencyCubit
import 'package:ccon/services/currency_service.dart'; // Import the CurrencyService

class AmountInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AmountInput({
    super.key,
    required this.controller,
    this.hintText = 'Enter amount',
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(12.0), // Border radius for rounded corners
      child: Container(
        color: Colors.grey[850], // Background color for the entire row
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0), // Padding inside the container
        child: Row(
          children: [
            Expanded(
              flex: 3, // Give more space to the TextField
              child: TextField(
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove borders from the TextField
                  labelText: hintText,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ), // Optional: text color for the label
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ), // Optional: text color for the input
                onChanged: (value) {
                  // Update the AmountCubit with the new amount
                  context.read<AmountCubit>().updateAmount(value);
                },
              ),
            ),
            const SizedBox(width: 16), // Space between input and selector

            // Provide a unique CurrencyCubit instance for the CurrencySelector
            Expanded(
              flex: 1,
              child: BlocProvider(
                create: (_) => CurrencyCubit(CurrencyService())
                  ..fetchCurrencies() // Fetch currencies when creating the cubit
                  ..selectCurrency('USD'), // Set the initial currency
                child: GlobalCurrencySelector(
                  initialCurrency: 'USD', // Example initial currency
                  onCurrencyChanged: (newCurrency) {
                    // Handle currency change logic here
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
