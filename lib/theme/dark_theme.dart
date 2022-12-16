import 'package:flutter/material.dart';

class DarkTheme {
  static final ThemeData theme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark().copyWith(
      onPrimary: Colors.lime[700],
      primary: Colors.grey[800],

      secondary: Colors.lime[700], 
      secondaryContainer: Colors.lime[800],
    ),
  );

}
