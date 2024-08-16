import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/blocs/global_currency_cubit.dart'; // Import the GlobalCurrencyCubit

class GlobalCurrencySelector extends StatelessWidget {
  final String initialCurrency;
  final Function(String) onCurrencyChanged;

  const GlobalCurrencySelector({
    Key? key,
    required this.initialCurrency,
    required this.onCurrencyChanged,
  }) : super(key: key);

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
          return Text('Loading...');
        }
      },
    );
  }
}
