import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static final CurrencyService _instance = CurrencyService._internal();

  factory CurrencyService() => _instance;

  CurrencyService._internal();

  Future<Map<String, double>> getLatestRates(String fromCurrency) async {
    final response = await http.get(
        Uri.parse('https://api.frankfurter.app/latest?from=$fromCurrency'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['rates'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value.toDouble()));
    } else {
      throw Exception('Failed to load currency rates');
    }
  }

  Future<List<String>> fetchCurrencies() async {
    final response =
        await http.get(Uri.parse('https://api.frankfurter.app/currencies'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> currencyMap = json.decode(response.body);
      return currencyMap.keys.toList();
    } else {
      throw Exception('Failed to load currencies');
    }
  }
}
