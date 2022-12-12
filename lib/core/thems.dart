// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

class MyThemes {
  static const COLOR_PRIMARY = Colors.deepOrangeAccent;
  static const COLOR_ACCENT = Colors.orange;

  static const Color primaryColor = Color(0xFF822685);
  static const Color secondColor = Color(0xFFF0800E);
  static const Color thirderyColor = Color(0xFFEEF5F9);

  static const Color blackColor = Color(0x00000000);
  static const Color pinkColor = Color(0x00000000);
  static const Color goldColor = Color(0xFFFFC23B);
  static const Color greyColor = Color(0xFFF5F5F5);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blueColor = Color(0xFF3282B8);
  static const Color cardcolor = Color.fromARGB(255, 120, 186, 230);
  static const Color cardcolorlight = Color(0xFFF5F5F5);

  static final lightThem = ThemeData(
    scaffoldBackgroundColor: thirderyColor,
    primaryColor: primaryColor,
    primarySwatch: Colors.green,
    brightness: Brightness.light,
    backgroundColor: goldColor,
    cardColor: cardcolorlight,
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 72.0, fontWeight: FontWeight.w600, color: goldColor),
      headline2: TextStyle(
          fontSize: 100.0, fontStyle: FontStyle.italic, color: blackColor),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
    appBarTheme: const AppBarTheme(
      color: blackColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            backgroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT))),

    /*  inputDecorationTheme: InputDecorationTheme(
         
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1))*/
  );

  static final darkTheme = ThemeData(
    /*  colorScheme: const ColorScheme.dark(
      primary: blackColor,
      secondary: whiteColor,
      onPrimary: greyColor,
    ),*/

    primarySwatch: Colors.blue,
    primaryColor: primaryColor,
    brightness: Brightness.dark,
    cardColor: cardcolor,
    // backgroundColor: bacgroundColor,
    // scaffoldBackgroundColor: Colors.blue,
    appBarTheme: const AppBarTheme(
      color: blueColor,
    ),
    //colorScheme: ColorScheme.dark(),
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 72.0, fontWeight: FontWeight.w600, color: goldColor),
      headline3: TextStyle(
          fontSize: 18.0, color: Colors.amber, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(color: Colors.black),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.blue,
    ),
  );
}
