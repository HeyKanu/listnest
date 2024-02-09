import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './full_data.dart';

class my_providers with ChangeNotifier {
  List<String> _forms_name = [];
  List<Color> _scc = [];

  String? _short_by_select = "Oldest";
  String? get Sort_By_Selection => _short_by_select;

  var _date;
  String get P_DATE => _date;
  final _my_row = <DataRow>[];
  bool _abc = true;
  List<String> get Forms_name => _forms_name;
  // List<Color> get SCC => _scc;
  bool get Abc => _abc;
  List<DataRow> get My_Row => _my_row;
  // var temp = _my_row.reversed;

  void Update_Sort_By(String? a) {
    _short_by_select = a;
    notifyListeners();
  }

  void Add_Row(List<DataCell> temp) {
    My_Row.add(DataRow(
      cells: temp,
    ));
    notifyListeners();
  }

  void Date_out(String d) {
    _date = d;
    notifyListeners();
  }

  void Delet_Row({required int i}) {
    My_Row.removeAt(i);
    print("My Rowes ==== $My_Row");
    notifyListeners();
  }

  void add_form_name(String name) {
    _forms_name.add(name);
    notifyListeners();
  }

  void set_abc(bool a) {
    _abc = a;
    notifyListeners();
  }

  void add_colors(Color a) {
    _scc.add(a);
    notifyListeners();
  }

  void replace_color(int index) {
    _scc.replaceRange(index, index + 1, [Color.fromARGB(108, 255, 255, 255)]);
    print(".....................");

    notifyListeners();
  }
}
