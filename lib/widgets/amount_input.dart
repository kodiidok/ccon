import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'currency_selector.dart'; // Import the CurrencySelector widget
import 'package:ccon/blocs/amount_cubit.dart'; // Import the AmountCubit

class AmountInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AmountInput({
    Key? key,
    required this.controller,
    this.hintText = 'Enter amount',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmountCubit, AmountState>(
      builder: (context, state) {
        // Initialize the controller text based on the state
        if (state is AmountInitial) {
          if (controller.text.isEmpty) {
            controller.text = state.amount;
          }
        } else if (state is AmountUpdated) {
          controller.text = state.amount;
        }

        return Row(
          children: [
            Expanded(
              flex: 3, // Give more space to the TextField
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: hintText,
                ),
                onChanged: (value) {
                  // Notify the Cubit of the new amount
                  context.read<AmountCubit>().updateAmount(value);
                },
              ),
            ),
            SizedBox(width: 16), // Space between input and selector
            Expanded(
              flex: 1, // Adjust the flex to fit the available space
              child: CurrencySelector(),
            ),
          ],
        );
      },
    );
  }
}
