
import 'package:flutter/material.dart';

class ShowDatePickedProvider extends ChangeNotifier {
  DateTime? _datePicked;

  DateTime? get datePicked => _datePicked;
  set datePicked(DateTime? date) {
    _datePicked = date;
    notifyListeners();
  }
}