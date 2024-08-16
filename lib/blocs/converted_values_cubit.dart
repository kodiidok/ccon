import 'package:ccon/services/currency_service.dart';
import 'package:ccon/services/preferences_service.dart';
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
  final PreferencesService _preferencesService;
  final List<CurrencyCubit> _currencyCubits;

  ConvertedValuesCubit(this._currencyService, this._preferencesService)
      : _currencyCubits = [],
        super(ConvertedValuesInitial([])) {
    _loadPreferredCurrencies();
  }

  void addConvertedValue([String? currency]) {
    final newCubit = CurrencyCubit(_currencyService);
    if (currency != null) {
      newCubit.selectCurrency(currency);
    }
    _currencyCubits.add(newCubit);
    _savePreferredCurrencies();
    emit(ConvertedValuesInitial(List.from(_currencyCubits)));
  }

  void removeConvertedValue(int index) {
    if (_currencyCubits.length > 1 &&
        index >= 0 &&
        index < _currencyCubits.length) {
      _currencyCubits.removeAt(index);
      _savePreferredCurrencies();
      emit(ConvertedValuesInitial(List.from(_currencyCubits)));
    }
  }

  CurrencyCubit getCurrencyCubit(int index) {
    return _currencyCubits[index];
  }

  Future<void> _loadPreferredCurrencies() async {
    final preferredCurrencies =
        await _preferencesService.getPreferredCurrencies();
    for (final currency in preferredCurrencies) {
      addConvertedValue(currency);
    }
    // Ensure at least one value is present
    if (_currencyCubits.isEmpty) {
      addConvertedValue();
    }
  }

  Future<void> _savePreferredCurrencies() async {
    final currencies = _currencyCubits
        .map((cubit) {
          if (cubit.state is CurrencyLoaded) {
            return (cubit.state as CurrencyLoaded).selectedCurrency;
          }
          return null;
        })
        .whereType<String>()
        .toList();
    await _preferencesService.savePreferredCurrencies(currencies);
  }
}
