import 'package:flutter/material.dart';

class ThemeApp {
  final BuildContext context;
  ThemeApp({required this.context});

  ThemeData vistoriaTheme() {
    return ThemeData(
      primarySwatch: Colors.purple,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(fontSize: 25),
      ),
    );
  }
}
