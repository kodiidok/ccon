import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyInputCubit extends Cubit<String> {
  Timer? _debounceTimer;

  CurrencyInputCubit() : super('');

  void updateInput(String input) {
    // Cancel any previous timer
    _debounceTimer?.cancel();

    // Set a new timer for 1 second
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      print('Timer fired with input: $input');
      emit(input);
    });
  }
}
