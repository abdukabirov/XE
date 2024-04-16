import 'package:flutter/material.dart';
import 'package:x_rate/api/currency_api.dart';

class CurrencyBody extends StatelessWidget {
  const CurrencyBody({
    super.key,
    required this.currency,
  });

  final CurrencyModel currency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(1),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(20),
        color: theme.cardColor,
      ),
      child: Row(
        children: [
          Image.network(currency.flagUrl, width: 70, height: 70),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currency.targetCurrency,
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  currency.currency_name,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${currency.rate.toStringAsFixed(2)} ${currency.display_symbol}',
                style: theme.textTheme.bodyMedium,
              ),
              Text(
                '1 ${currency.baseCode}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
