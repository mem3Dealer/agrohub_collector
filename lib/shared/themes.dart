import 'package:flutter/material.dart';

class AgrohubTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Color(0xffF1F1F1),
        disabledColor: Color(0xffE1EBEE),
        textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xff363B3F),
              fontSize: 32,
            ),
            headline1: TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(0xff363B3F),
                fontSize: 16),
            headline2: TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(0xff363B3F),
                fontSize: 18),
            headline3: TextStyle(
                color: Color(0xff363B3F),
                fontSize: 20,
                fontWeight: FontWeight.w700),
            headline4: TextStyle(
                color: Color(0xff363B3F),
                fontSize: 24,
                fontWeight: FontWeight.w500),
            caption: TextStyle(
                fontWeight: FontWeight.w400, color: Colors.red, fontSize: 16),
            subtitle1: TextStyle(
              color: Color(0xff999999),
              fontSize: 16,
            ),
            subtitle2: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.fromLTRB(16, 16, 0, 16),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff69A8BB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffCACED0)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff69A8BB),
              ),
            ),
            labelStyle: TextStyle(color: Color(0xffCACED0)),
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xffCACED0))),
        dividerTheme: DividerThemeData(
          thickness: 1.5,
          color: Color(0xff69A8BB),
        ),
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.white,
          secondary: Color(0xffE14D43),
          tertiary: Color(0xff69A8BB),
          error: Colors.red,
          surface: Colors.white,
          background: Color(0xffF1F1F1),
          onSurface: Color(0xff363B3F),
          onBackground: Colors.blue.shade900,
          onError: Colors.green,
          onPrimary: Color(0xff363B3F),
          onSecondary: Colors.amber,
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData();
  }
}
