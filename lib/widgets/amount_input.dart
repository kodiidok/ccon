import 'package:ccon/blocs/amount_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return TextField(
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
    );
  }
}
