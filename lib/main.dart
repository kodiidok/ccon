import 'package:ccon/screens/currency_exchange_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ccon/services/currency_service.dart';
import 'package:ccon/blocs/currency_cubit.dart';
import 'package:ccon/blocs/global_currency_cubit.dart';
import 'package:ccon/blocs/amount_cubit.dart';

void main() {
  runApp(const CurrencyExchangeApp());
}

class CurrencyExchangeApp extends StatelessWidget {
  const CurrencyExchangeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CurrencyService>(
          create: (_) => CurrencyService(), // Provide CurrencyService
        ),
        BlocProvider<CurrencyCubit>(
          create: (context) =>
              CurrencyCubit(context.read<CurrencyService>())..fetchCurrencies(),
        ),
        BlocProvider<GlobalCurrencyCubit>(
          create: (_) => GlobalCurrencyCubit(
              CurrencyService()), // Provide GlobalCurrencyCubit
        ),
        BlocProvider<AmountCubit>(
          create: (_) => AmountCubit(), // Provide AmountCubit
        ),
      ],
      child: MaterialApp(
        title: 'Currency Converter',
        theme: ThemeData(
          brightness: Brightness.dark, // Set the brightness to dark
          primarySwatch: Colors.blueGrey, // Optional: Set a dark primary color
          appBarTheme: AppBarTheme(
            color: Colors.grey[900], // Optional: Customize AppBar color
            titleTextStyle:
                const TextStyle(fontSize: 16), // Adjust AppBar title text size
          ),
          scaffoldBackgroundColor:
              Colors.grey[900], // Optional: Set background color for Scaffold
          textTheme: const TextTheme(
            bodyMedium:
                TextStyle(color: Colors.white), // Optional: Set text color
            bodySmall: TextStyle(
                color: Colors.white70), // Optional: Set secondary text color
          ),
          // Customize other theme properties as needed
        ),
        home: const CurrencyExchangeScreen(),
      ),
    );
  }
}
