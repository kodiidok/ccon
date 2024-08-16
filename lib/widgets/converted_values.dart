import 'package:ccon/blocs/amount_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertedValues extends StatelessWidget {
  const ConvertedValues({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmountCubit, AmountState>(
      builder: (context, state) {
        String displayedAmount = 'Converted Values will be displayed here';

        if (state is AmountUpdated) {
          displayedAmount = 'Amount: ${state.amount}';
        }

        return Center(
          child: Text(
            displayedAmount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
