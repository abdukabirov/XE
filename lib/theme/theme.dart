import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.indigo,
  scaffoldBackgroundColor: Colors.white.withOpacity(0.9),
  cardColor: Colors.black.withOpacity(0.1),
  fontFamily: 'SFPro',
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black.withOpacity(0.1),
    elevation: 0,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.w800,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.indigo),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white.withOpacity(0.7),
    selectedItemColor: Colors.indigo,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 19,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.black,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.green,
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.white.withOpacity(0.1),
  fontFamily: 'SFPro',
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white12,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.w800,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.green),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white12,
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 19,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.white,
    ),
  ),
);
