import 'package:flutter/material.dart';

import 'exchange_body.dart';
import 'sidebar.dart';

class Exchange extends StatefulWidget {
  final VoidCallback toggleTheme;

  const Exchange({
    super.key,
    required this.toggleTheme,
    required ThemeData theme,
  });

  @override
  ExchangeState createState() => ExchangeState();
}

class ExchangeState extends State<Exchange> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('XE'),
      ),
      endDrawer: Sidebar(
        toggleTheme: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
          widget.toggleTheme();
        },
        isDarkMode: isDarkMode,
      ),
      body: const SafeArea(
        child:
            ExchangeBody(), // Make sure you have this widget defined elsewhere
      ),
    );
  }
}
