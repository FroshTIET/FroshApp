import 'package:flutter/material.dart';

class Constants {
  static String appName = "Frosh 2K20";

  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.blueGrey[900];
  static Color darkAccent = Colors.white;
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color badgeColor = Colors.red;
  static bool isDarkTheme = false;

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: darkPrimary,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: darkBG,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    // brightness: Brightness.dark,
    // backgroundColor: darkBG,
    // primaryColor: darkPrimary,
    // accentColor: darkAccent,
    // scaffoldBackgroundColor: darkBG,
    // cursorColor: darkAccent,
    // indicatorColor: Colors.grey,
    // appBarTheme: AppBarTheme(
    //   elevation: 0,
    //   textTheme: TextTheme(
    //     headline6: TextStyle(
    //       color: lightBG,
    //       fontSize: 18.0,
    //       fontWeight: FontWeight.w800,
    //     ),
    //   ),
    // ),
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: darkPrimary,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: darkBG,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}
