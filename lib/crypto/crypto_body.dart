import 'package:flutter/material.dart';

import '../api/crypto_api.dart';

class CryptoBody extends StatelessWidget {
  const CryptoBody({
    super.key,
    required this.crypto,
  });

  final CryptoModel crypto;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color changeColor = crypto.isPriceIncreasing ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.all(1),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(20),
        color: theme.cardColor,
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Image.network(crypto.image, width: 60, height: 60),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crypto.name,
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  crypto.name,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${crypto.price.toStringAsFixed(3)} \$',
                style: theme.textTheme.bodyMedium,
              ),
              Text(
                '${crypto.percent.toStringAsFixed(2)} %',
                style: theme.textTheme.bodySmall?.copyWith(color: changeColor),
              ),
            ],
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
