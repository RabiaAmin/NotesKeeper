import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: TextTheme(
      bodySmall: TextStyle(color: Color.fromARGB(255, 145, 143, 143))),
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
        bodySmall: TextStyle(color: Color.fromARGB(250, 236, 235, 235))),
    appBarTheme: AppBarTheme(backgroundColor: Colors.transparent));
