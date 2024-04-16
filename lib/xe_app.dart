import 'package:flutter/material.dart';

import 'router/routes.dart';
import 'theme/theme.dart';

class XchangeApp extends StatefulWidget {
  const XchangeApp({super.key});

  @override
  XchangeAppState createState() => XchangeAppState();
}

class XchangeAppState extends State<XchangeApp> {
  ThemeData _currentTheme = lightTheme;

  void _toggleTheme() {
    setState(() {
      _currentTheme = (_currentTheme == lightTheme) ? darkTheme : lightTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomBar(
        toggleTheme: _toggleTheme,
        currentTheme: _currentTheme,
      ),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _currentTheme == lightTheme ? ThemeMode.light : ThemeMode.dark,
    );
  }
}
