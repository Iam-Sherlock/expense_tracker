import 'package:expense_tracker/widget/expenses.dart';
import 'package:flutter/material.dart';

var CustomColor =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(210, 226, 226, 226));
Object name = 5;
var CustomDarkColor = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(210, 194, 128, 255), brightness: Brightness.dark);
void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: CustomDarkColor,
      cardTheme: CardTheme().copyWith(
          color: CustomDarkColor.onPrimary,
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: CustomDarkColor.primaryContainer,
      )),
    ),
    theme: ThemeData().copyWith(
        colorScheme: CustomColor,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: CustomColor.onPrimaryContainer,
            foregroundColor: CustomColor.secondaryContainer),
        cardTheme: CardTheme().copyWith(
            color: CustomColor.onPrimary,
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: CustomColor.primaryContainer,
        )),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.red,
                fontSize: 16))),
    themeMode: ThemeMode.dark,
    home: Expenses(),
  ));
}
