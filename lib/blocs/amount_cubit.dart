import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
abstract class AmountState {}

class AmountInitial extends AmountState {
  final String amount;

  AmountInitial([this.amount = '0.00']); // Default amount
}

class AmountUpdated extends AmountState {
  final String amount;

  AmountUpdated(this.amount);
}

class AmountCubit extends Cubit<AmountState> {
  AmountCubit() : super(AmountInitial());

  void updateAmount(String amount) {
    emit(AmountUpdated(amount));
  }
}
