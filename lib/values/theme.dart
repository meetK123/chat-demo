import 'package:flutter/material.dart';

final ThemeData light = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245), //#F5F5F5
    fontFamily: 'Poppins',
    dividerColor: const Color.fromARGB(255, 238, 238, 238),
    disabledColor: const Color.fromARGB(255, 92, 92, 92),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.black87,
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      centerTitle: true,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme.light(
      background: Color.fromARGB(255, 245, 245, 245),
      onBackground: Color.fromARGB(255, 60, 60, 60),
      primary: Color.fromARGB(255, 23, 81, 165),
      onPrimary: Colors.white,
      secondary: Color.fromARGB(255, 94, 0, 218),
      onSecondary: Color.fromARGB(255, 255, 255, 255),
      onTertiary: Color.fromARGB(255, 170, 170, 170),
      primaryContainer: Colors.white,
      onPrimaryContainer: Color.fromARGB(255, 92, 92, 92),
      secondaryContainer: Color.fromARGB(255, 215, 215, 215),
      onSecondaryContainer: Color.fromARGB(255, 155, 155, 155),

      // below are colors for shimmer
      tertiaryContainer: Color.fromARGB(255, 250, 250, 250),
      onTertiaryContainer: Color.fromARGB(255, 225, 225, 225),
    ));
final ThemeData dark = ThemeData(
  scaffoldBackgroundColor: const Color.fromRGBO(21, 21, 21, 1),
  fontFamily: 'Poppins',
  dividerColor: const Color.fromARGB(20, 23, 86, 175),
  disabledColor: const Color.fromARGB(255, 189, 189, 189),
  appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Color.fromARGB(0, 255, 255, 255),
      foregroundColor: Color.fromARGB(255, 218, 218, 218),
      centerTitle: true),
  bottomSheetTheme:
  const BottomSheetThemeData(backgroundColor: Color.fromARGB(255, 22, 22, 22)),
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 21, 21, 21),
    onBackground: Color.fromARGB(255, 218, 218, 218),
    primary: Color.fromARGB(255, 23, 81, 165),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 94, 0, 218),
    onSecondary: Colors.white,
    onTertiary: Color.fromARGB(255, 136, 136, 136),
    primaryContainer: Color.fromARGB(255, 35, 35, 35),
    onPrimaryContainer: Color.fromARGB(255, 189, 189, 189),
    secondaryContainer: Color.fromARGB(255, 160, 160, 160),
    onSecondaryContainer: Color.fromARGB(255, 170, 170, 170),

    // below are colors for shimmer
    tertiaryContainer: Color.fromARGB(255, 189, 189, 189),
    onTertiaryContainer: Color.fromARGB(255, 35, 35, 35),
  ),
);
