import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'SfProDisplay'),
      ),
      scaffoldBackgroundColor: const Color.fromRGBO(246, 246, 249, 1),
      fontFamily: 'SfProDisplay',
    );
  }
}