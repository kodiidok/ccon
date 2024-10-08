import 'package:ccon/blocs/currency_cubit.dart';
import 'package:ccon/services/currency_service.dart';
import 'package:ccon/widgets/currency_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/blocs/global_currency_cubit.dart';
import 'package:ccon/blocs/amount_cubit.dart';

class ConvertedValue extends StatelessWidget {
  final CurrencyCubit currencyCubit;

  const ConvertedValue({super.key, required this.currencyCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: currencyCubit,
      child: BlocBuilder<AmountCubit, AmountState>(
        builder: (context, amountState) {
          double amount = 0.0;

          if (amountState is AmountUpdated) {
            amount = double.tryParse(amountState.amount) ?? 0.0;
          }

          return BlocBuilder<GlobalCurrencyCubit, GlobalCurrencyState>(
            builder: (context, globalCurrencyState) {
              String globalSelectedCurrency = 'USD';

              if (globalCurrencyState is GlobalCurrencyLoaded) {
                globalSelectedCurrency =
                    globalCurrencyState.selectedCurrency ?? 'USD';
              }

              return BlocBuilder<CurrencyCubit, CurrencyState>(
                builder: (context, currencyState) {
                  String localSelectedCurrency = globalSelectedCurrency;

                  if (currencyState is CurrencyLoaded) {
                    localSelectedCurrency = currencyState.selectedCurrency ??
                        globalSelectedCurrency;
                  }

                  return FutureBuilder<double>(
                    future: _fetchConversionRate(
                      context.read<CurrencyService>(),
                      globalSelectedCurrency,
                      localSelectedCurrency,
                    ),
                    builder: (context, snapshot) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                            12.0), // Border radius for rounded corners
                        child: Container(
                          color: Colors.grey[
                              850], // Background color for the entire row
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Text(
                                      snapshot.hasData ? (amount * (snapshot.data ?? 1.0)).toStringAsFixed(2) : '0.00',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting)
                                      const Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              CurrencySelector(
                                initialCurrency: localSelectedCurrency,
                                onCurrencyChanged: (newCurrency) {
                                  currencyCubit.selectCurrency(newCurrency);
                                },
                              ),
                            ],
                          ), //
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
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
      if (kDebugMode) {
        print('Error fetching conversion rate: $e');
      }
      return 1.0;
    }
  }
}
