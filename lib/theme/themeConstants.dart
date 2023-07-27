import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: Typography.blackHelsinki,
  elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueGrey),
  )),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: Typography.whiteHelsinki,
  elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueGrey),
  )),
);

