// import 'package:ccon/blocs/currency_cubit.dart';
// import 'package:ccon/services/currency_service.dart';
// import 'package:ccon/widgets/currency_selector.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ccon/blocs/global_currency_cubit.dart'; // Import the GlobalCurrencyCubit
// import 'package:ccon/blocs/amount_cubit.dart';

// class ConvertedValue extends StatelessWidget {
//   const ConvertedValue({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AmountCubit, AmountState>(
//       builder: (context, amountState) {
//         // Default amount display
//         String amountText = 'Amount: 0.00';

//         if (amountState is AmountUpdated) {
//           // Use the updated amount from the state
//           amountText = 'Amount: ${amountState.amount}';
//         }

//         return BlocBuilder<GlobalCurrencyCubit, GlobalCurrencyState>(
//           builder: (context, globalCurrencyState) {
//             // Default currency display
//             String globalSelectedCurrency = 'USD';

//             if (globalCurrencyState is GlobalCurrencyLoaded) {
//               globalSelectedCurrency = globalCurrencyState.selectedCurrency ?? 'USD';
//             }

//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     '$amountText', // show the amount in converted currency (converted from global currency to local currency) 
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16), // Spacing between amount and currency selector
//                 Expanded(
//                   child: BlocProvider(
//                     create: (_) => CurrencyCubit(CurrencyService()) // Provide CurrencyCubit for local currency selection
//                       ..fetchCurrencies() // Fetch currencies when creating the cubit
//                       ..selectCurrency(globalSelectedCurrency), // Set the initial currency
//                     child: CurrencySelector(
//                       initialCurrency: globalSelectedCurrency,
//                       onCurrencyChanged: (newCurrency) {
//                         // Handle local currency change
//                         context.read<CurrencyCubit>().selectCurrency(newCurrency);
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }




import 'package:ccon/blocs/currency_cubit.dart';
import 'package:ccon/services/currency_service.dart';
import 'package:ccon/widgets/currency_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/blocs/global_currency_cubit.dart'; // Import the GlobalCurrencyCubit
import 'package:ccon/blocs/amount_cubit.dart';

class ConvertedValue extends StatelessWidget {
  const ConvertedValue({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmountCubit, AmountState>(
      builder: (context, amountState) {
        // Default amount display
        double amount = 0.0;

        if (amountState is AmountUpdated) {
          // Use the updated amount from the state
          amount = double.tryParse(amountState.amount) ?? 0.0;
        }

        return BlocBuilder<GlobalCurrencyCubit, GlobalCurrencyState>(
          builder: (context, globalCurrencyState) {
            // Default currency display
            String globalSelectedCurrency = 'USD';

            if (globalCurrencyState is GlobalCurrencyLoaded) {
              globalSelectedCurrency = globalCurrencyState.selectedCurrency ?? 'USD';
            }

            return BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, currencyState) {
                // Default local currency
                String localSelectedCurrency = globalSelectedCurrency;

                if (currencyState is CurrencyLoaded) {
                  localSelectedCurrency = currencyState.selectedCurrency ?? globalSelectedCurrency;
                }

                return FutureBuilder<double>(
                  future: _fetchConversionRate(
                    context.read<CurrencyService>(),
                    globalSelectedCurrency,
                    localSelectedCurrency,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error fetching conversion rate'));
                    }

                    final conversionRate = snapshot.data ?? 1.0;
                    final convertedAmount = (amount * conversionRate).toStringAsFixed(2);

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Amount: $convertedAmount $localSelectedCurrency',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 16), // Spacing between amount and currency selector
                        Expanded(
                          child: BlocProvider(
                            create: (_) => CurrencyCubit(CurrencyService())
                              ..fetchCurrencies() // Fetch currencies when creating the cubit
                              ..selectCurrency(globalSelectedCurrency), // Set the initial currency
                            child: CurrencySelector(
                              initialCurrency: globalSelectedCurrency,
                              onCurrencyChanged: (newCurrency) {
                                // Handle local currency change
                                context.read<CurrencyCubit>().selectCurrency(newCurrency);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Future<double> _fetchConversionRate(
    CurrencyService currencyService,
    String fromCurrency,
    String toCurrency,
  ) async {
    try {
      return await currencyService.getConversionRate(fromCurrency, toCurrency);
    } catch (e) {
      // Handle errors appropriately
      print('Error fetching conversion rate: $e');
      return 1.0; // Default to 1.0 if there is an error
    }
  }
}
