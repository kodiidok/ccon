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
    Key? key,
    required this.controller,
    this.hintText = 'Enter amount',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3, // Give more space to the TextField
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: hintText,
            ),
            onChanged: (value) {
              // Update the AmountCubit with the new amount
              context.read<AmountCubit>().updateAmount(value);
            },
          ),
        ),
        SizedBox(width: 16), // Space between input and selector

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
    );
  }
}
