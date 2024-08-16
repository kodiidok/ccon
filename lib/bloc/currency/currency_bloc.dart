// bloc/currency/currency_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ccon/bloc/currency/currency_event.dart';
import 'package:ccon/bloc/currency/currency_state.dart';
import 'package:ccon/services/currency_service.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyService currencyService;

  CurrencyBloc(this.currencyService) : super(CurrencyInitial()) {
    on<FetchCurrencies>(_onFetchCurrencies);
  }

  Future<void> _onFetchCurrencies(
      FetchCurrencies event, Emitter<CurrencyState> emit) async {
    emit(CurrencyLoading());
    try {
      final currencies = await currencyService.fetchCurrencies();
      emit(CurrencyLoaded(currencies));
    } catch (error) {
      emit(CurrencyError(error.toString()));
    }
  }
}
