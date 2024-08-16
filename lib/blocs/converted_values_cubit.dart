import 'package:ccon/services/currency_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit State
class ConvertedValuesState extends Equatable {
  final List<String> convertedValues; // List to store converted value data
  final String inputValue;

  const ConvertedValuesState({
    this.convertedValues = const [],
    this.inputValue = '',
  });

  @override
  List<Object> get props => [convertedValues, inputValue];
}

// Cubit for managing converted values
class ConvertedValuesCubit extends Cubit<ConvertedValuesState> {
  final CurrencyService _currencyService = CurrencyService();

  ConvertedValuesCubit() : super(const ConvertedValuesState());

  // Add a new converted value to the list
  void addConvertedValue() {
    emit(ConvertedValuesState(
      convertedValues: [
        ...state.convertedValues,
        ''
      ], // Empty string as placeholder
    ));
  }

  // Remove a converted value at a specific index
  void removeConvertedValue(int index) {
    final updatedList = List<String>.from(state.convertedValues)
      ..removeAt(index);
    emit(ConvertedValuesState(convertedValues: updatedList));
  }

  // Update a specific converted value
  void updateConvertedValue(int index, String value) {
    final updatedList = List<String>.from(state.convertedValues);
    updatedList[index] = value;
    emit(ConvertedValuesState(convertedValues: updatedList));
  }

  // Update the input value and recalculate converted values
  Future<void> updateInputValue(String fromCurrency, String inputValue) async {
    print('updateInputValue called with fromCurrency: $fromCurrency, inputValue: $inputValue');
    try {
      emit(ConvertedValuesState(
        convertedValues: state.convertedValues, // No change in converted values
        inputValue: inputValue,
      ));
      print('Updated input value: $inputValue');
    } catch (e) {
      // Handle errors, such as network issues
      print('Error fetching rates: $e');
    }
  }
}
