import 'package:ccon/blocs/amount_cubit.dart';
import 'package:ccon/widgets/amount_input.dart';
import 'package:ccon/widgets/converted_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyExchangeScreen extends StatelessWidget {
  const CurrencyExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return BlocProvider(
      create: (_) => AmountCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Currency Exchange Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
              AmountInput(controller: controller),
              SizedBox(height: 20),
              Text(
                'CONVERT TO',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: ConvertedValues(), // This will fill remaining space
              ),
            ],
          ),
        ),
      ),
    );
  }
}
