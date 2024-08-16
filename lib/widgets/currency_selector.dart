import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/blocs/currency_cubit.dart'; // Import the CurrencyCubit

class CurrencySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyCubit, CurrencyState>(
      builder: (context, state) {
        if (state is CurrencyLoaded) {
          return SizedBox(
            width: double.infinity, // Makes the DropdownButton take available width
            child: DropdownButton<String>(
              isExpanded: true, // Expands the dropdown button to fit the parent
              value: state.selectedCurrency,
              items: state.currencies.map((currency) {
                return DropdownMenuItem(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                // Update the selected currency
                context.read<CurrencyCubit>().selectCurrency(value);
              },
            ),
          );
        } else if (state is CurrencyError) {
          return Text('Error: ${state.message}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
