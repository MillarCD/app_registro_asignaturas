

import 'package:flutter/material.dart';

class LightTheme {
  static final ThemeData theme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light().copyWith(

      primary: Colors.grey[300],
      primaryContainer: Colors.grey[500],
      onPrimary: Colors.lime[900],

      secondary: Colors.lime[700], 
      secondaryContainer: Colors.lime[900],
      onSecondary: Colors.black,

      background: Colors.grey[100],
    ),
  );

}
