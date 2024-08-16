import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/services/currency_service.dart';

// Define the states for the GlobalCurrencyCubit
abstract class GlobalCurrencyState {}

class GlobalCurrencyInitial extends GlobalCurrencyState {}

class GlobalCurrencyLoaded extends GlobalCurrencyState {
  final List<String> currencies;
  final String? selectedCurrency;

  GlobalCurrencyLoaded(this.currencies, this.selectedCurrency);
}

class GlobalCurrencyError extends GlobalCurrencyState {
  final String message;

  GlobalCurrencyError(this.message);
}

// Define the GlobalCurrencyCubit
class GlobalCurrencyCubit extends Cubit<GlobalCurrencyState> {
  final CurrencyService _currencyService;

  GlobalCurrencyCubit(this._currencyService) : super(GlobalCurrencyInitial()) {
    fetchCurrencies();
  }

  // Fetch the list of currencies and set the initial selected currency
  Future<void> fetchCurrencies() async {
    try {
      final currencies = await _currencyService.fetchCurrencies();
      emit(GlobalCurrencyLoaded(
          currencies, currencies.isNotEmpty ? currencies[0] : null));
    } catch (e) {
      emit(GlobalCurrencyError(e.toString()));
    }
  }

  // Update the selected currency
  void selectCurrency(String? currency) {
    final state = this.state;
    if (state is GlobalCurrencyLoaded) {
      emit(GlobalCurrencyLoaded(state.currencies, currency));
    }
  }
}
