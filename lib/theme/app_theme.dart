import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    // textTheme: GoogleFonts.mulishTextTheme(
    //         Theme.of(context).textTheme,
    //       ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.blueColor,
    ),
  );
}
