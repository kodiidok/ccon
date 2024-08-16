// bloc/currency/currency_event.dart
import 'package:equatable/equatable.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();
}

class FetchCurrencies extends CurrencyEvent {
  @override
  List<Object> get props => [];
}
