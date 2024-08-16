import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/blocs/currency_cubit.dart';

class CurrencySelector extends StatelessWidget {
  final String initialCurrency;
  final Function(String) onCurrencyChanged;

  const CurrencySelector({
    super.key,
    required this.initialCurrency,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyCubit, CurrencyState>(
      builder: (context, currencyState) {
        if (currencyState is CurrencyLoaded) {
          final currencies = currencyState.currencies;
          final selectedCurrency = currencyState.selectedCurrency ?? initialCurrency;

          return DropdownButton<String>(
            value: selectedCurrency,
            onChanged: (newCurrency) {
              if (newCurrency != null) {
                // Update the Cubit with the new selected currency
                context.read<CurrencyCubit>().selectCurrency(newCurrency);
                onCurrencyChanged(newCurrency);
              }
            },
            underline: Container(),
            items: currencies.map<DropdownMenuItem<String>>((String currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child: Text(currency),
              );
            }).toList(),
          );
        } else if (currencyState is CurrencyError) {
          return Text('Error: ${currencyState.message}');
        } else {
          return const Text('Loading...');
        }
      },
    );
  }
}
