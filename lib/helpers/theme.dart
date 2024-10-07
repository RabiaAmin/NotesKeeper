import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
        bodySmall: TextStyle(color: Color.fromARGB(205, 210, 209, 209))),
    appBarTheme: AppBarTheme(backgroundColor: Colors.transparent));
