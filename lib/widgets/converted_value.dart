import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/blocs/currency_cubit.dart';
import 'package:ccon/blocs/amount_cubit.dart';

class ConvertedValue extends StatelessWidget {
  const ConvertedValue({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmountCubit, AmountState>(
      builder: (context, amountState) {
        return BlocBuilder<CurrencyCubit, CurrencyState>(
          builder: (context, currencyState) {
            String amountText = 'Amount: ';
            String currencyText = 'Currency: ';

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
            if (currencyState is CurrencyLoaded) {
              final selectedCurrency = currencyState.selectedCurrency;
              currencyText += selectedCurrency != null
                  ? selectedCurrency
                  : 'No currency selected';
            } else if (currencyState is CurrencyError) {
              currencyText += 'Error: ${currencyState.message}';
            } else {
              currencyText +=
                  'No currency loaded'; // Fallback for initial state
            }

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
                SizedBox(width: 16), // Spacing between amount and currency
                Expanded(
                  child: Text(
                    currencyText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
