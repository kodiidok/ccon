import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/blocs/currency_cubit.dart';
import 'package:ccon/blocs/amount_cubit.dart';
import 'currency_selector.dart'; // Import the CurrencySelector widget

class ConvertedValue extends StatelessWidget {
  const ConvertedValue({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmountCubit, AmountState>(
      builder: (context, amountState) {
        // Default amount display
        String amountText = 'Amount: 0.00';

        if (amountState is AmountUpdated) {
          // Use the updated amount from the state
          amountText = 'Amount: ${amountState.amount}';
        }

        return BlocBuilder<CurrencyCubit, CurrencyState>(
          builder: (context, currencyState) {
            // Default currency display
            String selectedCurrency = 'USD';

            if (currencyState is CurrencyLoaded) {
              selectedCurrency = currencyState.selectedCurrency ?? 'USD';
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '$amountText $selectedCurrency',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 16), // Spacing between amount and currency selector
                Expanded(
                  child: CurrencySelector(
                    initialCurrency: selectedCurrency,
                    onCurrencyChanged: (newCurrency) {
                      // Handle currency change
                      context
                          .read<CurrencyCubit>()
                          .selectCurrency(newCurrency);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
