import 'package:ccon/blocs/currency/currency_cubit.dart';
import 'package:ccon/widgets/currency_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyExchangeCubit, String>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current Currency: $state',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20),
              const CurrencySelectorWidget(), // Add the dropdown selector widget here
            ],
          ),
        );
      },
    );
  }
}
