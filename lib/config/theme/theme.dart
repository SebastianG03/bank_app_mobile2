import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomTheme {
  const CustomTheme();

  static const Color background = Color(0xFFF3F3F3);
  static const Color appBar = Color(0xFF860A35);
  static const Color buttonPrimary = Color.fromARGB(226, 150, 208, 253);
  static const Color buttonPrimaryGradient = Color.fromARGB(215, 41, 105, 162);
  static const Color buttonSecondary = Color.fromARGB(255, 84, 255, 141);
  static const Color buttonSecondaryGradient =
      Color.fromARGB(221, 39, 180, 131);
  static const Color selected = Color(0xFFD93668);
  static const Color enableOutlineBorder = Colors.black;
  static const Color focusOutlineBorder = Color(0xFF0DC3E8);
  static const Color errorOutlineBorder = Color.fromARGB(255, 208, 9, 9);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      buttonTheme: const ButtonThemeData(
        padding: EdgeInsets.all(15),
        splashColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enableOutlineBorder),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusOutlineBorder),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorOutlineBorder),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)),
        ),
      ));
}
