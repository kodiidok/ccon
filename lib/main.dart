import 'package:ccon/blocs/currency_cubit.dart';
import 'package:ccon/screens/currency_exchange_screen.dart';
import 'package:ccon/screens/main_screen.dart';
import 'package:ccon/services/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import the CurrencyService

void main() => runApp(const CurrencyExchangeApp());

class CurrencyExchangeApp extends StatelessWidget {
  const CurrencyExchangeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CurrencyExchangeCubit(CurrencyService()),
        child: const MainScreen(),
      ),
      routes: {
        '/currency_exchange': (context) => BlocProvider(
              create: (_) => CurrencyExchangeCubit(CurrencyService()),
              child: const CurrencyExchangeScreen(),
            ),
      },
    );
  }
}
