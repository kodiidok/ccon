import 'package:ccon/blocs/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencySelectorWidget extends StatelessWidget {
  const CurrencySelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyExchangeCubit, String>(
      builder: (context, state) {
        final currencies = context.read<CurrencyExchangeCubit>().currencies;

        return DropdownButton<String>(
          value: state,
          onChanged: (newCurrency) {
            if (newCurrency != null) {
              context.read<CurrencyExchangeCubit>().selectCurrency(newCurrency);
            }
          },
          items: currencies.map((currency) {
            return DropdownMenuItem<String>(
              value: currency,
              child: Text(currency),
            );
          }).toList(),
          isExpanded: false, // Ensure it fits content width
          elevation: 0, // Remove elevation for a flat dropdown
          underline: const SizedBox.shrink(), // Remove the underline
        );
      },
    );
  }
}
