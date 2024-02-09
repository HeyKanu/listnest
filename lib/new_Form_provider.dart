import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class new_form_provider with ChangeNotifier {
  double _height_Of_Container = 70;
  bool _edit_box = false;

  bool get Edit_Box => _edit_box;
  double get Height_Of_Container => _height_Of_Container;

  void Update_Container_Height(double a) {
    _height_Of_Container = a;
    notifyListeners();
  }

  void Update_Edit_Box(bool a) {
    _edit_box = a;
    notifyListeners();
  }
}

class new_form_app_bar with ChangeNotifier {
  bool _loder = false;

  bool get Loder => _loder;

  void Update_Loader(bool a) {
    _loder = a;
    notifyListeners();
  }
}
