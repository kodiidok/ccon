import 'package:ccon/blocs/currency_cubit.dart';
import 'package:ccon/widgets/currency_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertedValueWidget extends StatelessWidget {
  final int index;
  final String initialValue;

  const ConvertedValueWidget({
    super.key,
    required this.index,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyExchangeCubit, String>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.grey[200], // Light grey background
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min, // Adjust to fit content
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '0', // Placeholder text
                    border: InputBorder.none, // Remove the border
                  ),
                  style: TextStyle(fontSize: 16),
                  readOnly: true, // Set to false if you need it editable
                ),
              ),
              SizedBox(width: 8), // Reduced spacing
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: double.infinity, // Make dropdown fit the width
                  child: CurrencySelectorWidget(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
