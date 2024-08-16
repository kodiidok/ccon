class CurrencyModel {
  final String base;
  final DateTime date;
  final Map<String, double> rates;

  CurrencyModel({
    required this.base,
    required this.date,
    required this.rates,
  });

  // Factory constructor to create a CurrencyModel from JSON data
  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      base: json['base'],
      date: DateTime.parse(json['date']),
      rates: Map<String, double>.from(json['rates']),
    );
  }

  // Method to convert CurrencyModel to JSON format (optional)
  Map<String, dynamic> toJson() {
    return {
      'base': base,
      'date': date.toIso8601String(),
      'rates': rates,
    };
  }
}
