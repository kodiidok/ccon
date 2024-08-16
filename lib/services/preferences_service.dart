import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _preferredCurrenciesKey = 'preferred_currencies';

  Future<void> savePreferredCurrencies(List<String> currencies) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_preferredCurrenciesKey, currencies);
  }

  Future<List<String>> getPreferredCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_preferredCurrenciesKey) ?? [];
  }
}
