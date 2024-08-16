import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/blocs/global_currency_cubit.dart'; // Import the GlobalCurrencyCubit

class GlobalCurrencySelector extends StatelessWidget {
  final String initialCurrency;
  final Function(String) onCurrencyChanged;

  const GlobalCurrencySelector({
    super.key,
    required this.initialCurrency,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCurrencyCubit, GlobalCurrencyState>(
      builder: (context, globalCurrencyState) {
        if (globalCurrencyState is GlobalCurrencyLoaded) {
          final currencies = globalCurrencyState.currencies;
          final selectedCurrency =
              globalCurrencyState.selectedCurrency ?? initialCurrency;

          return DropdownButton<String>(
            value: selectedCurrency,
            onChanged: (newCurrency) {
              if (newCurrency != null) {
                // Update the GlobalCurrencyCubit with the new selected currency
                context.read<GlobalCurrencyCubit>().selectCurrency(newCurrency);
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
        } else if (globalCurrencyState is GlobalCurrencyError) {
          return Text('Error: ${globalCurrencyState.message}');
        } else {
          return const Text('Loading...');
        }
      },
    );
  }
}
