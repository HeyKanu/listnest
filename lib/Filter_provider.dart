import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class F_provider with ChangeNotifier {
  bool _date_change = false;
  bool get Date_Change => _date_change;
  void Update_Date(bool a) {
    _date_change = a;
    notifyListeners();
  }

  Color _D_filter_option = Colors.white; // selected container color
  var _height_of_container = 0.0;
  Color _V_filter_option =
      const Color.fromARGB(255, 255, 85, 7); // selected container color
  var _pull_Icon = Icon(
    Icons.arrow_drop_down_outlined,
    color: const Color.fromARGB(255, 0, 0, 0),
    size: 50,
  );
  String _current_optino = "Greater";
  bool _range = false;
  bool _date = true;
  bool _value = false;
  var _selectedValue_Date;
  var _selectedValue_Value;

  String? get Selected_Value_Date => _selectedValue_Date;
  String? get Selected_Value_Value => _selectedValue_Value;
  bool get Date_active => _date;
  // bool get Value_active => _value;
  bool get Range => _range;
  String get Current_option => _current_optino;
  Icon get Pull_Icons => _pull_Icon;
  Color get D_Filter_Color => _D_filter_option;
  double get Height_Of_Container => _height_of_container;
  Color get V_Filter_Color => _V_filter_option;

  void Update_Date_active(bool a) {
    _date = a;

    notifyListeners();
  }

  void Update_Selected_Value_Date(var a) {
    _selectedValue_Date = a;

    notifyListeners();
  }

  void Update_Selected_Value_Value(var a) {
    _selectedValue_Value = a;
    notifyListeners();
  }

  void Update_Range(var a) {
    _range = a;
    notifyListeners();
  }

  void Update_Curent_Option(String a) {
    _current_optino = a;
    notifyListeners();
  }

  void Update_Icon(Icon x) {
    _pull_Icon = x;
    notifyListeners();
  }

  void Update_Height(var a) {
    _height_of_container = a;
    notifyListeners();
  }

  void Change_D_color(Color a) {
    _D_filter_option = a;
    notifyListeners();
  }

  void Change_V_color(Color a) {
    _V_filter_option = a;
    notifyListeners();
  }
}
