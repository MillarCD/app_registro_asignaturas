import 'package:flutter/material.dart';

import 'package:asignaturas/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  final Map<String, ThemeData> _themes = {
    'light': LightTheme.theme,
    'dark': DarkTheme.theme
  };

  String _themeSelected = 'light';
  ThemeData _theme = LightTheme.theme;
  ThemeData get theme => _theme;

  String get themeSelected => _themeSelected;
  set themeSelected(String newTheme) {
    if (_themes[newTheme] == null) return;

    _themeSelected = newTheme;
    _theme = _themes[newTheme]!;
    notifyListeners();
  }

}