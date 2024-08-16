import 'package:ccon/blocs/converted_values_cubit.dart';
import 'package:ccon/widgets/converted_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertedValuesWidget extends StatelessWidget {
  const ConvertedValuesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConvertedValuesCubit, ConvertedValuesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Loop through converted values and create a row for each
            for (int i = 0; i < state.convertedValues.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0), // Small gap between rows
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ConvertedValueWidget(
                        index: i,
                        initialValue: state.convertedValues[i],
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        context.read<ConvertedValuesCubit>().removeConvertedValue(i);
                      },
                    ),
                  ],
                ),
              ),
            if (state.convertedValues.isEmpty) 
              const Center(
                child: Text('No converters added.'),
              ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.read<ConvertedValuesCubit>().addConvertedValue();
              },
              child: const Text('Add Converter'),
            ),
          ],
        );
      },
    );
  }
}
