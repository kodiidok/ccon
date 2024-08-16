import 'package:ccon/blocs/converted_values_cubit.dart';
import 'package:ccon/widgets/converted_values.dart';
import 'package:ccon/widgets/currency_input.dart'; // Update path if necessary
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyExchangeScreen extends StatelessWidget {
  const CurrencyExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Exchange Screen'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ConvertedValuesCubit>(
            create: (context) => ConvertedValuesCubit(),
          ),
          // Other providers (like CurrencyInputCubit) can go here
        ],
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INSERT AMOUNT',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              CurrencyInputWidget(),
              SizedBox(height: 20),
              Text(
                'CONVERT TO',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ConvertedValuesWidget(), // This now uses the Cubit
            ],
          ),
        ),
      ),
    );
  }
}
