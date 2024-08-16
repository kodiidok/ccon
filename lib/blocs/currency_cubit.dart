import 'package:ccon/services/currency_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<String> currencies;

  CurrencyLoaded(this.currencies);
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError(this.message);
}

class CurrencyCubit extends Cubit<CurrencyState> {
  final CurrencyService _currencyService;

  CurrencyCubit(this._currencyService) : super(CurrencyInitial());

  Future<void> fetchCurrencies() async {
    try {
      final currencies = await _currencyService.fetchCurrencies();
      emit(CurrencyLoaded(currencies));
    } catch (e) {
      emit(CurrencyError(e.toString()));
    }
  }
}
