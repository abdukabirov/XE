import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:x_rate/api/exchange_api.dart';

class ExchangeBody extends StatefulWidget {
  const ExchangeBody({super.key});

  @override
  ExchangeBodyState createState() => ExchangeBodyState();
}

class ExchangeBodyState extends State<ExchangeBody> {
  String fromCurrency = 'GBP';
  String toCurrency = 'EUR';
  double? amount;
  String result = '';
  final ExchangeAPI api = ExchangeAPI();

  void _openCurrencyPicker(bool isFromCurrency) {
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        setState(() {
          if (isFromCurrency) {
            fromCurrency = currency.code;
          } else {
            toCurrency = currency.code;
          }
        });
      },
    );
  }

  void _switchCurrencies() {
    setState(() {
      String temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
    });
  }

  void convertCurrency() async {
    if (amount == null || amount! <= 0) {
      setState(() {
        result = 'Please enter a valid amount';
      });
      return;
    }

    try {
      String conversionResult =
          await api.convertCurrency(fromCurrency, toCurrency, amount!);
      setState(() {
        result = conversionResult;
      });
    } catch (error) {
      setState(() {
        result = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          IntrinsicHeight(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _currencyCard(
                      fromCurrency, () => _openCurrencyPicker(true)),
                ),
                GestureDetector(
                  onTap: _switchCurrencies,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Icon(
                        Icons.swap_horiz_rounded,
                        key: ValueKey<String>(fromCurrency + toCurrency),
                        size: 40.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _currencyCard(
                      toCurrency, () => _openCurrencyPicker(false)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
              hintText: 'Enter amount in $fromCurrency',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    amount = null;
                  });
                },
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) =>
                setState(() => amount = double.tryParse(value)),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: convertCurrency,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            child: Text(
              'Convert',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            result.isNotEmpty ? 'Converted Amount: $result' : '',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _currencyCard(String currencyCode, VoidCallback onTap) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                currencyCode,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
