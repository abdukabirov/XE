import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_keys.dart';

class CurrencyModel {
  final String baseCode;
  final String targetCurrency;
  final double rate;
  final String flagUrl;
  final String display_symbol;
  final String currency_name;

  CurrencyModel({
    required this.baseCode,
    required this.targetCurrency,
    required this.rate,
    required this.flagUrl,
    required this.display_symbol,
    required this.currency_name,
  });
}

Future<List<CurrencyModel>> getCurrencies() async {
  const baseCurrency = 'GBP';
  final targetCurrencies = [
    'USD',
    'EUR',
    'JPY',
    'GBP',
    'AUD',
    'CAD',
    'CHF',
    'CNY',
    'SEK',
    'NZD',
    'SGD',
    'HKD',
    'NOK',
    'KRW',
    'MXN',
    'INR',
    'BRL',
    'ZAR',
    'RUB',
    'TRY',
    'AED',
    'THB',
    'PLN',
    'DKK',
    'TWD',
    'MYR',
    'IDR',
    'HUF',
    'CZK',
    'ILS',
    'PHP',
    'CLP',
    'QAR',
    'SAR',
    'EGP',
    'KWD',
    'OMR',
    'VND',
    'UAH'
  ];

  List<CurrencyModel> result = [];
  for (final targetCurrency in targetCurrencies) {
    String apiKey = YOUR_SECRET_API;
    final url =
        'https://v6.exchangerate-api.com/v6/$apiKey/enriched/$baseCurrency/$targetCurrency';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final baseCode = data['base_code'];
      final conversionRate = data['conversion_rate'];
      final flagUrl = data['target_data']['flag_url'];
      final displaySymbol = data['target_data']['display_symbol'];
      final currencyName = data['target_data']['currency_name'];

      // Function to convert Unicode hex references to display symbols
      String convertUnicodeToSymbol(String unicode) {
        List<String> hexCodes = unicode.split(',');
        String symbol = '';
        for (String hexCode in hexCodes) {
          int code = int.parse(hexCode, radix: 16);
          symbol += String.fromCharCode(code);
        }
        return symbol;
      }

      final currencySymbol = convertUnicodeToSymbol(displaySymbol);

      final exchangeRate = CurrencyModel(
        baseCode: baseCode,
        targetCurrency: targetCurrency,
        rate: conversionRate.toDouble(),
        flagUrl: flagUrl,
        display_symbol: currencySymbol,
        currency_name: currencyName,
      );

      result.add(exchangeRate);
    }
  }

  return result;
}
