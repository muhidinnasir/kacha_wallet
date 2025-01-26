import 'package:flutter/material.dart';
import 'constants.dart';

class AppThemes {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryYellow,
    scaffoldBackgroundColor: lightBackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryYellow,
      foregroundColor: lightTextColor,
      elevation: 0,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryYellow,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: lightTextColor),
      bodyLarge: TextStyle(fontSize: 16, color: lightTextColor),
    ),
    cardTheme: CardTheme(
      color: lightCardColor,
      shadowColor: Colors.grey.shade200,
      elevation: 4,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryDark,
    scaffoldBackgroundColor: darkBackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryDark,
      foregroundColor: darkTextColor,
      elevation: 0,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: darkTextColor,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: darkTextColor),
    ),
    cardTheme: const CardTheme(
      color: darkCardColor,
      shadowColor: Colors.black,
      elevation: 4,
    ),
  );
}
