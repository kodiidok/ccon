import 'package:ccon/blocs/converted_values_cubit.dart';
import 'package:ccon/services/currency_service.dart';
import 'package:ccon/services/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'converted_value.dart';

class ConvertedValues extends StatelessWidget {
  const ConvertedValues({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConvertedValuesCubit(CurrencyService(),
          PreferencesService()), // Pass the PreferencesService
      child: BlocBuilder<ConvertedValuesCubit, ConvertedValuesState>(
        builder: (context, state) {
          if (state is ConvertedValuesInitial) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var i = 0; i < state.convertedValues.length; i++)
                  Column(
                    children: [
                      SizedBox(
                        height: 60, // Fixed height for each row
                        child: Row(
                          children: [
                            Expanded(
                              child: ConvertedValue(
                                currencyCubit: context
                                    .read<ConvertedValuesCubit>()
                                    .getCurrencyCubit(i),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle),
                              color: Colors.red,
                              onPressed: () {
                                context
                                    .read<ConvertedValuesCubit>()
                                    .removeConvertedValue(i);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4), // Gap between rows
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 32.0,
                      bottom: 8.0), // Add top margin and bottom padding
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ConvertedValuesCubit>().addConvertedValue();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      foregroundColor: Colors.lightGreen,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal:
                              16.0), // Optional: Add padding inside the button
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize
                          .min, // Make the Row take up only as much width as necessary
                      children: [
                        Icon(Icons.add,
                            color: Colors.lightGreen), // Add plus icon
                        SizedBox(width: 8.0), // Space between icon and text
                        Text('ADD CONVERTER'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
