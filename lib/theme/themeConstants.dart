import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: TextStyle(
        fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black54),
    displaySmall: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black87),
    // headlineLarge: TextStyle(color: Colors.black54),
    // headlineMedium: TextStyle(color: Colors.black54),
    // headlineSmall: TextStyle(color: Colors.black54),
    // titleLarge: TextStyle(color: Colors.black54),
    // titleMedium: TextStyle(color: Colors.black54),
    // titleSmall: TextStyle(color: Colors.black54),
    // bodyLarge: TextStyle(color: Colors.black54),
    // bodyMedium: TextStyle(color: Colors.black54),
    // bodySmall: TextStyle(color: Colors.black54),
    // labelLarge: TextStyle(color: Colors.black54),
    // labelMedium: TextStyle(color: Colors.black54),
    // labelSmall: TextStyle(color: Colors.black54),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor:
        MaterialStateColor.resolveWith((states) => Colors.blueGrey),
  )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.black,
  )
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(
        fontSize: 32, fontWeight: FontWeight.w500, color: Colors.white38),
    displaySmall: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white70),
    // headlineLarge: TextStyle(color: Colors.white38),
    // headlineMedium: TextStyle(color: Colors.white38),
    // headlineSmall: TextStyle(color: Colors.white38),
    // titleLarge: TextStyle(color: Colors.white38),
    // titleMedium: TextStyle(color: Colors.white38),
    // titleSmall: TextStyle(color: Colors.white38),
    // bodyLarge: TextStyle(color: Colors.white38),
    // bodyMedium: TextStyle(color: Colors.white38),
    // bodySmall: TextStyle(color: Colors.white38),
    // labelLarge: TextStyle(color: Colors.white38),
    // labelMedium: TextStyle(color: Colors.white38),
    // labelSmall: TextStyle(color: Colors.white38),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor:
        MaterialStateColor.resolveWith((states) => Colors.blueGrey),
  )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
  )
);
