import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class S_F_Provider with ChangeNotifier {
  bool _date_change = false;
  bool get Date_Change => _date_change;
  void Update_Date(bool a) {
    _date_change = a;
    notifyListeners();
  }
}
