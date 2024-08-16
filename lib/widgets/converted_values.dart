import 'package:ccon/blocs/converted_values_cubit.dart';
import 'package:ccon/services/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'converted_value.dart';

class ConvertedValues extends StatelessWidget {
  const ConvertedValues({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConvertedValuesCubit(CurrencyService()),
      child: BlocBuilder<ConvertedValuesCubit, ConvertedValuesState>(
        builder: (context, state) {
          if (state is ConvertedValuesInitial) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var i = 0; i < state.convertedValues.length; i++)
                  Row(
                    children: [
                      Expanded(
                        child: ConvertedValue(
                          currencyCubit: context
                              .read<ConvertedValuesCubit>()
                              .getCurrencyCubit(i),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          context
                              .read<ConvertedValuesCubit>()
                              .removeConvertedValue(i);
                        },
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ConvertedValuesCubit>().addConvertedValue();
                    },
                    child: Text('Add Converted Value'),
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
