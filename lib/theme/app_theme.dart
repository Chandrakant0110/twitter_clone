import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    // textTheme: ThemeData.dark().textTheme.apply(
    //       fontFamily: 'Helvetica',
    //     ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.blueColor,
    ),
  );
}
