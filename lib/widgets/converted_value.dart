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
        return BlocBuilder<CurrencyCubit, CurrencyState>(
          builder: (context, currencyState) {
            String amountText = 'Amount: ';

            // Handle AmountState
            if (amountState is AmountUpdated) {
              // Use the amount provided by the state or default to '0.00'
              String amount =
                  amountState.amount.isNotEmpty ? amountState.amount : '0.00';
              amountText += amount;
            } else if (amountState is AmountInitial) {
              amountText += '0.00'; // Default amount
            }

            // Handle CurrencyState
            String initialCurrency = currencyState is CurrencyLoaded
                ? currencyState.selectedCurrency ?? ''
                : '';

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    amountText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                    width: 16), // Spacing between amount and currency selector
                Expanded(
                  child: CurrencySelector(
                    initialCurrency: initialCurrency,
                    onCurrencyChanged: (selectedCurrency) {
                      // Handle currency change
                      context
                          .read<CurrencyCubit>()
                          .selectCurrency(selectedCurrency);
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
