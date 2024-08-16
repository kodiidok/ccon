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
        return TextField(
          controller: TextEditingController(text: input),
          decoration: const InputDecoration(
            border: InputBorder.none, // Remove the border
          ),
          style: const TextStyle(
            fontSize: 24.0, // Set the desired font size
          ),
          onChanged: (text) {
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
