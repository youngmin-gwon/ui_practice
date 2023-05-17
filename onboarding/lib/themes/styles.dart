import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Colors.blue,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF425398),
      ),
      bodySmall: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF425398),
      ),
      titleMedium: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF425398),
      ),
      bodyMedium: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 17,
        fontWeight: FontWeight.normal,
        color: Color(0xFF425398),
      ),
    ),
  );
}
