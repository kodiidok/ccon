import 'package:ccon/services/currency_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyExchangeCubit extends Cubit<String> {
  final CurrencyService _currencyService;
  List<String> _currencies = [];

  CurrencyExchangeCubit(this._currencyService) : super('USD') {
    _loadCurrencies();
  }

  List<String> get currencies => _currencies;
  
  Future<void> selectCurrency(String currency) async {
    if (_currencies.contains(currency)) {
      emit(currency);
    }
  }
  
  Future<void> _loadCurrencies() async {
    try {
      _currencies = await _currencyService.fetchCurrencies();
      emit(
          state); // Ensure the current state is valid after fetching currencies
    } catch (_) {
      // Handle error
    }
  }

  Future<void> nextCurrency() async {
    final currentIndex = _currencies.indexOf(state);
    final nextIndex = (currentIndex + 1) % _currencies.length;
    emit(_currencies[nextIndex]);
  }

  Future<void> previousCurrency() async {
    final currentIndex = _currencies.indexOf(state);
    final prevIndex =
        (currentIndex - 1 + _currencies.length) % _currencies.length;
    emit(_currencies[prevIndex]);
  }
}
