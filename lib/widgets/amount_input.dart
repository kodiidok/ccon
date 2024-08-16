import 'package:ccon/blocs/currency_cubit.dart';
import 'package:ccon/blocs/currency_input_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountInputWidget extends StatelessWidget {
  const AmountInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyInputCubit, String>(
      builder: (context, input) {
        // Set default value if input is empty
        final displayValue = input.isEmpty ? '0.00' : input;

        return TextField(
          // Initialize the TextEditingController with the display value
          controller: TextEditingController(text: displayValue)
            ..selection = TextSelection.collapsed(offset: displayValue.length),
          decoration: const InputDecoration(
            border: InputBorder.none, // Remove the border
          ),
          style: const TextStyle(
            fontSize: 24.0, // Set the desired font size
          ),
          onChanged: (text) {
            // Ensure the input value is updated in the cubit
            context.read<CurrencyInputCubit>().updateInput(text);
          },
          onSubmitted: (submittedInput) {
            final currencies = context.read<CurrencyExchangeCubit>().currencies;
            if (currencies.contains(submittedInput.toUpperCase())) {
              context
                  .read<CurrencyExchangeCubit>()
                  .selectCurrency(submittedInput.toUpperCase());
              context.read<CurrencyInputCubit>().updateInput('');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid currency code'),
                ),
              );
            }
          },
        );
      },
    );
  }
}
