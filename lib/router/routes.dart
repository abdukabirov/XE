import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '/crypto/crypto.dart';
import '/currency/currency.dart';
import '/exchange/exchange.dart';

final routes = {
  '/Crypto': (context) => Crypto(
        toggleTheme: () {},
        theme: darkTheme,
      ),
  '/Currency': (context) => Currency(
        toggleTheme: () {},
        theme: darkTheme,
      ),
  '/Exchange': (context) => Exchange(
        toggleTheme: () {},
        theme: darkTheme,
      ),
};

class BottomBar extends StatefulWidget {
  const BottomBar(
      {super.key, required this.toggleTheme, required this.currentTheme});

  final VoidCallback toggleTheme;
  final ThemeData currentTheme;

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          Crypto(
            toggleTheme: widget.toggleTheme,
            theme: darkTheme,
          ),
          Currency(
            toggleTheme: widget.toggleTheme,
            theme: darkTheme,
          ),
          Exchange(
            toggleTheme: widget.toggleTheme,
            theme: darkTheme,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 250),
            curve: Curves.linear,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin_rounded),
            label: 'Crypto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_pound_rounded),
            label: 'Currency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            label: 'Exchange',
          ),
        ],
      ),
    );
  }
}
