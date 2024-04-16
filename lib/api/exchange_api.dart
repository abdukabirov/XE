import 'dart:convert';

import 'package:http/http.dart' as http;

class ExchangeAPI {
  Future<String> convertCurrency(
      String fromCurrency, String toCurrency, double amount) async {
    var url = Uri.parse(
        'https://v6.exchangerate-api.com/v6/5fb3455e274574813e93639a/pair/$fromCurrency/$toCurrency/$amount');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['result'] == 'success') {
        double result = jsonResponse['conversion_result'];
        return '${result.toStringAsFixed(2)} $toCurrency';
      } else {
        return 'Error: ${jsonResponse['error-type']}';
      }
    } else {
      return 'Server error with status code: ${response.statusCode}';
    }
  }
}
