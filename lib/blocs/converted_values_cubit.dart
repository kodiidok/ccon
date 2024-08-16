
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit State
class ConvertedValuesState extends Equatable {
  final List<String> convertedValues; // List to store converted value data

  const ConvertedValuesState({this.convertedValues = const []});

  @override
  List<Object> get props => [convertedValues];
}

// Cubit for managing converted values
class ConvertedValuesCubit extends Cubit<ConvertedValuesState> {
  ConvertedValuesCubit() : super(const ConvertedValuesState());

  // Add a new converted value to the list
  void addConvertedValue() {
    emit(ConvertedValuesState(
      convertedValues: [...state.convertedValues, ''], // Empty string as placeholder
    ));
  }

  // Remove a converted value at a specific index
  void removeConvertedValue(int index) {
    final updatedList = List<String>.from(state.convertedValues)..removeAt(index);
    emit(ConvertedValuesState(convertedValues: updatedList));
  }

  // Update a specific converted value
  void updateConvertedValue(int index, String value) {
    final updatedList = List<String>.from(state.convertedValues);
    updatedList[index] = value;
    emit(ConvertedValuesState(convertedValues: updatedList));
  }
}
