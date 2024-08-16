import 'package:ccon/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/bloc/currency/currency_bloc.dart';
import 'package:ccon/services/currency_service.dart'; // Import your ConverterScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyBloc(CurrencyService()),
      child: const MaterialApp(
        title: 'Currency Converter',
        home: MainScreen(), // Your main screen
      ),
    );
  }
}
