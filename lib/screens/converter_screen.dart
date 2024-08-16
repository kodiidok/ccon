import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/bloc/currency/currency_bloc.dart';
import 'package:ccon/bloc/currency/currency_event.dart';
import 'package:ccon/bloc/currency/currency_state.dart';
import 'package:ccon/widgets/currency_input.dart'; // Adjust the import path as needed

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _initialAmountController = TextEditingController();
  String _initialSelectedCurrency = 'USD'; // Default selected currency
  final List<CurrencyInput> _currencyInputs = [];

  @override
  void initState() {
    super.initState();
    context.read<CurrencyBloc>().add(FetchCurrencies());
  }

  void _addCurrencyInput() {
    setState(() {
      _currencyInputs.add(
        CurrencyInput(
          amountController: TextEditingController(),
          selectedCurrency: _initialSelectedCurrency,
          isEditable: true,
          onCurrencyChanged: (value) {
            // Handle currency change if needed
          },
          // isEditable: false, // Set to false for non-editable inputs
          onRemove: () {
            setState(() {
              if (_currencyInputs.isNotEmpty) {
                _currencyInputs.removeLast();
              }
            });
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Exchanger'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CurrencyBloc, CurrencyState>(
          builder: (context, state) {
            if (state is CurrencyLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('INSERT AMOUNT',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  CurrencyInput(
                    amountController: _initialAmountController,
                    selectedCurrency: _initialSelectedCurrency,
                    isEditable: true,
                    onCurrencyChanged: (value) {
                      setState(() {
                        _initialSelectedCurrency = value ?? 'USD';
                      });
                    },
                    onRemove: null,
                  ),
                  const SizedBox(height: 16),
                  const Text('CONVERT TO',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Column(
                    children: _currencyInputs.map((input) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CurrencyInput(
                          amountController: input.amountController,
                          selectedCurrency: input.selectedCurrency,
                          onCurrencyChanged: input.onCurrencyChanged,
                          isEditable: false,
                          onRemove: input.onRemove,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addCurrencyInput,
                    child: const Text('Add Converter'),
                  ),
                ],
              );
            } else if (state is CurrencyLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CurrencyError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}