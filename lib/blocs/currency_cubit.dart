import 'package:ccon/services/currency_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<String> currencies;
  final String? selectedCurrency;

  CurrencyLoaded(this.currencies, this.selectedCurrency);
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError(this.message);
}

class CurrencyCubit extends Cubit<CurrencyState> {
  final CurrencyService _currencyService;

  CurrencyCubit(this._currencyService) : super(CurrencyInitial()) {
    fetchCurrencies();
  }

  Future<void> fetchCurrencies() async {
    try {
      final currencies = await _currencyService.fetchCurrencies();
      emit(CurrencyLoaded(currencies, currencies.isNotEmpty ? currencies[0] : null));
    } catch (e) {
      emit(CurrencyError(e.toString()));
    }
  }

  void selectCurrency(String? currency) {
    final state = this.state;
    if (state is CurrencyLoaded) {
      emit(CurrencyLoaded(state.currencies, currency));
    }
  }
}
