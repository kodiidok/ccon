import 'package:ccon/services/currency_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'currency_cubit.dart';

abstract class ConvertedValuesState {
  const ConvertedValuesState();
}

class ConvertedValuesInitial extends ConvertedValuesState {
  final List<CurrencyCubit> convertedValues;

  const ConvertedValuesInitial(this.convertedValues);
}

class ConvertedValuesCubit extends Cubit<ConvertedValuesState> {
  final CurrencyService _currencyService;
  final List<CurrencyCubit> _currencyCubits;

  ConvertedValuesCubit(this._currencyService)
      : _currencyCubits = [],
        super(const ConvertedValuesInitial([]));

  void addConvertedValue() {
    final newCubit = CurrencyCubit(_currencyService);
    _currencyCubits.add(newCubit);
    emit(ConvertedValuesInitial(
        List.from(_currencyCubits))); // Ensures a new list instance
  }

  void removeConvertedValue(int index) {
    if (index >= 0 && index < _currencyCubits.length) {
      _currencyCubits.removeAt(index);
      emit(ConvertedValuesInitial(
          List.from(_currencyCubits))); // Ensures a new list instance
    }
  }

  CurrencyCubit getCurrencyCubit(int index) {
    return _currencyCubits[index];
  }
}
