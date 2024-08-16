import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/bloc/currency/currency_bloc.dart';
import 'package:ccon/bloc/currency/currency_state.dart';

class CurrencyInput extends StatelessWidget {
  final TextEditingController amountController;
  final String selectedCurrency;
  final ValueChanged<String?>? onCurrencyChanged;
  final bool isEditable; // Added isEditable for TextField
  final VoidCallback? onRemove;

  const CurrencyInput({
    super.key,
    required this.amountController,
    required this.selectedCurrency,
    required this.isEditable, // Make sure to require isEditable
    this.onCurrencyChanged,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: amountController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '0',
                contentPadding: EdgeInsets.zero,
              ),
              keyboardType: TextInputType.number,
              enabled: isEditable, // Apply isEditable only to TextField
            ),
          ),
          const SizedBox(width: 8),
          BlocBuilder<CurrencyBloc, CurrencyState>(
            builder: (context, state) {
              if (state is CurrencyLoading) {
                return const CircularProgressIndicator();
              } else if (state is CurrencyLoaded) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCurrency,
                    onChanged: onCurrencyChanged, // Always enabled
                    items: state.currencies
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                );
              } else if (state is CurrencyError) {
                return Text(state.message);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          if (onRemove != null)
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }
}
