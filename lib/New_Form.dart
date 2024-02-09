// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, non_constant_identifier_names, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:list_nest2/new_Form_provider.dart';
import 'package:provider/provider.dart';
// import 'package:get/get.dart';
import './show_form.dart';

class New_Form extends StatefulWidget {
  var Form_name;

  // List<String>? Filds_Name;
  List<String>? Leble_Text_L; // L for Load
  List<String>? Hint_Text_L;
  List<Widget>? Form_Fields_L;
  List<String>? Filds_Name_L;
  List<String>? All_Forms_Names;
  List<String>? Trash;
  bool? update;

  var Grid_column_L;
  bool? load;

  New_Form(
      {required this.Form_name,
      this.Filds_Name_L,
      this.Form_Fields_L,
      this.Hint_Text_L,
      this.Leble_Text_L,
      this.load,
      this.Grid_column_L,
      this.All_Forms_Names,
      this.update,
      this.Trash});

  @override
  State<New_Form> createState() => _New_FormState();
}

class _New_FormState extends State<New_Form> {
  List<String> Leble_Text = []; // Text Filds Lable
  List<String> Hint_Text = []; // Text Filds Hint
  List<Widget> Form_Fields = []; // List of Fields creat by user
  List<String> Filds_Name = [];
  List<String> submit_date = [];
  List<String> submit_time = [];
  List<String> user_id = [];
  List<int> index_data = [];

  List<List<String>> user_values = [];

  // double height_Of_Container = 70;
  // bool loder = false;
  User? currrent_user = FirebaseAuth.instance.currentUser;
  int Grid_column = 1;
  double height_of_field = 80;

  var index_Num; //Selected field
  void Refresh([int i = 1]) {
    Grid_column = i;
    setState(() {});
  }

  void chang_Hei_f(double h) {
    height_of_field = h;
    setState(() {});
  }

  void Add_Hint_Lable({required String L, required String H}) {
    Leble_Text.add(L);
    Hint_Text.add(H);

    // print(Text_Filds_Hint.length);
    print(Leble_Text);
    setState(() {});
  }

  Color body_color = Color.fromARGB(255, 255, 239, 230);
  Color text_fill_color = Color.fromARGB(255, 255, 255, 255);
  Color text__enab_border_color = Color.fromARGB(255, 0, 0, 0);
  Color orange_color = Color.fromARGB(255, 255, 81, 0);
  Color hadder_color = Color.fromARGB(255, 255, 81, 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Leble_Text.clear();
    Hint_Text.clear();
    Form_Fields.clear();
    Filds_Name.clear();
    if (widget.load == true) {
      print("....................... ${widget.update}");
      print(widget.Filds_Name_L);

      for (int i = 0; i < widget.Filds_Name_L!.length; i++) {
        Leble_Text.add(widget.Leble_Text_L![i]);
        Hint_Text.add(widget.Hint_Text_L![i]);
        Form_Fields.add(widget.Form_Fields_L![i]);
        Filds_Name.add(widget.Filds_Name_L![i]);
      }
      Grid_column = widget.Grid_column_L;
    }
  }

  void Add_Fields({required String field, required int index_of_H_L}) {
    if (field == "Text") {
      Form_Fields.add(
        TextFormField(
          onChanged: (value) {},
          decoration: InputDecoration(
            prefix: Text(" "),
            hintText: Hint_Text[index_of_H_L],
            labelText: Leble_Text[index_of_H_L],
            filled: true,
            fillColor: text_fill_color,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    } else if (field == "Date") {
      Form_Fields.add(
        Container(
          color: text_fill_color,
          child: Center(
            child: Text("${DateTime.now()}"),
          ),
        ),
      );
    } else if (field == "Text Area") {
      Form_Fields.add(
        TextFormField(
          minLines: 1,
          maxLines: 4,
          decoration: InputDecoration(
            prefix: Text(" "),
            labelText: Leble_Text[index_of_H_L],
            contentPadding: EdgeInsets.zero,
            filled: true,
            fillColor: text_fill_color,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    } else if (field == "Num") {
      Form_Fields.add(
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefix: Text(" "),
            contentPadding: EdgeInsets.zero,
            hintText: Hint_Text[index_of_H_L],
            labelText: Leble_Text[index_of_H_L],
            filled: true,
            fillColor: text_fill_color,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    } else if (field == "Mobile No") {
      Form_Fields.add(
        TextFormField(
          keyboardType: TextInputType.phone,
          // obscureText: true,
          decoration: InputDecoration(
            helperMaxLines: 10,
            prefix: Text(" "),
            contentPadding: EdgeInsets.zero,
            hintText: Hint_Text[index_of_H_L],
            labelText: Leble_Text[index_of_H_L],
            filled: true,
            fillColor: text_fill_color,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    } else if (field == "Drop Down") {
      Form_Fields.add(DropdownMenu(dropdownMenuEntries: []));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider_object =
        Provider.of<new_form_provider>(context, listen: false);
    final provider_object2 =
        Provider.of<new_form_app_bar>(context, listen: false);
    return WillPopScope(
        onWillPop: () async {
          final Value = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Alert",
                  style: TextStyle(color: Colors.red),
                ),
                content: Text("Do You want to exit ?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text("Ok")),
                ],
              );
            },
          );
          if (Value != null) {
            return Future.value(Value);
          } else {
            return Future.value(false);
          }
        },
        child: Scaffold(
          drawer: My_Drawer(
            Form_name: widget.Form_name,
            Refresh: Refresh,
            height_ch: chang_Hei_f,
          ),
          appBar: AppBar(
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
            // forceMaterialTransparency: true,
            backgroundColor: hadder_color,
            centerTitle: true,
            title: Text(
              widget.Form_name,
              // style: TextStyle(color: Colors.black),
            ),
            actions: [
              Consumer<new_form_app_bar>(
                builder: (context, value, child) {
                  return value.Loder
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 1, 1, 27),
                          ))
                      : Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () async {
                              value.Update_Loader(true);
                              // loder = true;
                              // setState(() {});
                              print("Form name ---- ${widget.Form_name}");
                              // widget.Form_name.insert(0, widget.Form_name);
                              Map<String, String> Map_Filds_Name =
                                  {}; //firebase me store karne ke liye map me convert kiya
                              Map<String, String> Map_Leble_Text =
                                  {}; //firebase me store karne ke liye map me convert kiya
                              Map<String, String> Map_Hint_Text =
                                  {}; //firebase me store karne ke liye map me convert kiya
                              for (int i = 0; i < Filds_Name!.length; i++) {
                                print("Filds name ==== ${Filds_Name[i]}");
                                Map_Filds_Name[i.toString()] = Filds_Name![i];
                              }
                              Map_Filds_Name["UserId"] =
                                  "${currrent_user?.uid}";
                              Map_Filds_Name["Length"] =
                                  "${Filds_Name!.length}";
                              Map_Filds_Name["Grid"] = Grid_column.toString();
                              print("Filds name MAp ==== ${Map_Filds_Name}");
                              await FirebaseFirestore.instance
                                  .collection("${currrent_user?.uid}")
                                  .doc(widget.Form_name)
                                  .collection("form_list")
                                  .doc("filds name")
                                  .set(Map_Filds_Name);
                              print("Data sand Done.....................");

                              for (int i = 0; i < Leble_Text.length; i++) {
                                Map_Leble_Text[i.toString()] = Leble_Text[i];
                              }
                              Map_Leble_Text["UserId"] =
                                  "${currrent_user?.uid}";
                              Map_Leble_Text["Length"] = "${Leble_Text.length}";

                              await FirebaseFirestore.instance
                                  .collection("${currrent_user?.uid}")
                                  .doc(widget.Form_name)
                                  .collection("form_list")
                                  .doc("Lables Text")
                                  .set(Map_Leble_Text);
                              for (int i = 0; i < Hint_Text.length; i++) {
                                Map_Hint_Text[i.toString()] = Hint_Text[i];
                              }
                              Map_Hint_Text["UserId"] = "${currrent_user?.uid}";
                              Map_Hint_Text["Length"] =
                                  "${Hint_Text.length.toString()}";
                              print("Lables name MAp ==== ${Map_Hint_Text}");
                              await FirebaseFirestore.instance
                                  .collection("${currrent_user?.uid}")
                                  .doc(widget.Form_name)
                                  .collection("form_list")
                                  .doc("hint Text")
                                  .set(Map_Hint_Text);
                              print(Map_Filds_Name);
                              // widget.Filds_Name!.clear();
                              // Hint_Text.clear();
                              // Leble_Text.clear();
                              print("Done...........");
                              if (widget.update == true) {
                                print("Done 2 ...........");
                                widget.All_Forms_Names!
                                    .insert(0, widget.Form_name);
                                Map<String, String> Map_Form_Names = {};
                                for (int i = 0;
                                    i < widget.All_Forms_Names!.length;
                                    i++) {
                                  Map_Form_Names[i.toString()] =
                                      widget.All_Forms_Names![i];
                                }
                                Map_Form_Names["userId"] =
                                    currrent_user!.uid.toString();
                                Map_Form_Names["Length"] =
                                    widget.All_Forms_Names!.length.toString();

                                await FirebaseFirestore.instance
                                    .collection("${currrent_user!.uid}")
                                    .doc("names")
                                    .set(Map_Form_Names);

                                Map<String, String> Map_Trash = {};
                                for (int i = 0; i < widget.Trash!.length; i++) {
                                  Map_Trash[i.toString()] = widget.Trash![i];
                                }
                                print("M=== ${Map_Trash}");
                                Map_Trash["userId"] =
                                    currrent_user!.uid.toString();
                                Map_Trash["Length"] =
                                    widget.Trash!.length.toString();

                                await FirebaseFirestore.instance
                                    .collection("${currrent_user!.uid}")
                                    .doc("Trash")
                                    .set(Map_Trash);
                              }
                              if (widget.update == false) {
                                print("user Length = ${user_values.length}");
                                for (var i = 0; i < user_values.length; i++) {
                                  Map<String, dynamic> Map_User_entries = {};
                                  int a = user_values[i].length;
                                  print("lennnnnnnnnnnnnn...............$a");
                                  for (var j = 0; j < a; j++) {
                                    Map_User_entries[j.toString()] =
                                        user_values[i][j];
                                    print("kk********** ${user_values[i][j]}");
                                  }
                                  print("Map==== ${Map_User_entries}");
                                  print("submit_date==== ${submit_date[i]}");
                                  print("submit_time==== ${submit_time[i]}");
                                  print("index_data==== ${index_data[i]}");
                                  Map_User_entries["Date"] = submit_date[i];
                                  Map_User_entries["Time"] = submit_time[i];
                                  Map_User_entries["Index"] = index_data[i];
                                  Map_User_entries["uid"] = currrent_user!.uid;
                                  Map_User_entries["Length"] = a.toString();
                                  print("iiiii======${i}");
                                  print(
                                      "Map of user entry _______________ ${Map_User_entries}");
                                  FirebaseFirestore.instance
                                      .collection("${currrent_user?.uid}")
                                      .doc(widget.Form_name)
                                      .collection("User_entries")
                                      .doc(user_id[i])
                                      .set(Map_User_entries);
                                }
                              }
                              value.Update_Loader(false);
                              // widget.update = true;
                              // loder = false;

                              Get.off(() => Show_my_form(
                                    Form_Name: widget.Form_name,
                                    update: false,
                                    Trash: [],
                                    Sum: 1,
                                  ));

                              // setState(() {});
                            },
                            child: Icon(
                              Icons.save_as_outlined,
                              size: 30,
                            ),
                          ),
                        );
                },
              )
            ],
          ),
          body: Container(
              decoration: BoxDecoration(color: body_color
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Color.fromARGB(255, 1, 11, 20),
                  //     Color.fromARGB(255, 4, 31, 54),
                  //   ],
                  //   transform: GradientRotation(40),
                  //   // stops: [0.5, 0],
                  // ),
                  ),
              child: Column(
                children: [
                  Consumer<new_form_provider>(builder: (context, value, child) {
                    return Expanded(
                      child: Column(
                        children: [
                          // ________________________________________________________________________________   (  Edit Box  )    _______________________________________________________________________
                          value.Edit_Box
                              ? AnimatedContainer(
                                  duration: Duration(microseconds: 100000),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  height: 215,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Table(
                                            // border: TableBorder.all(),
                                            columnWidths: {
                                              0: FixedColumnWidth(85),
                                              2: FixedColumnWidth(50),
                                            },
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            children: [
                                              TableRow(
                                                children: [
                                                  Text("Lable Text"),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5),
                                                    height: 30,
                                                    width: 100,
                                                    child: TextFormField(
                                                      controller:
                                                          TextEditingController(
                                                        text: Leble_Text[
                                                            index_Num],
                                                      ),
                                                      onChanged: (value) {
                                                        Leble_Text.replaceRange(
                                                            index_Num,
                                                            index_Num + 1,
                                                            [value]);
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton.outlined(
                                                    onPressed: () {
                                                      Form_Fields.removeAt(
                                                          index_Num!.toInt());
                                                      Filds_Name!.removeAt(
                                                          index_Num!.toInt());
                                                      Leble_Text.removeAt(
                                                          index_Num!.toInt());
                                                      Hint_Text.removeAt(
                                                          index_Num!.toInt());
                                                      for (int i = 0;
                                                          i <
                                                              user_values
                                                                  .length;
                                                          i++) {
                                                        user_values[i].removeAt(
                                                            index_Num!.toInt());
                                                      }
                                                      print(
                                                          "entry ${user_values}");
                                                      value.Update_Edit_Box(
                                                          false);
                                                      // edit_Box = false;
                                                      // setState(() {});
                                                    },
                                                    icon: Icon(Icons.delete),
                                                  )
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Text("Hint Text"),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5),
                                                    height: 30,
                                                    width: 100,
                                                    child: TextFormField(
                                                      controller:
                                                          TextEditingController(
                                                        text: Hint_Text[
                                                            index_Num],
                                                      ),
                                                      onChanged: (value) {
                                                        Hint_Text.replaceRange(
                                                            index_Num,
                                                            index_Num + 1,
                                                            [value]);
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox()
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 5, left: 10),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.check_box,
                                                          color: Color.fromARGB(
                                                              255, 1, 33, 70),
                                                        ),
                                                        Text(" Number"),
                                                      ],
                                                    )),
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 5, left: 22),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.check_box,
                                                          color: Color.fromARGB(
                                                              255, 1, 33, 70),
                                                        ),
                                                        Text(" Date"),
                                                      ],
                                                    )),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 5, left: 10),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.check_box,
                                                          color: Color.fromARGB(
                                                              255, 1, 33, 70),
                                                        ),
                                                        Text(" Password"),
                                                      ],
                                                    )),
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 5, left: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.check_box,
                                                        color: Color.fromARGB(
                                                            255, 1, 33, 70),
                                                      ),
                                                      Text(" Phone Number"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              value.Update_Edit_Box(false);
                                              // edit_Box = false;
                                              print(Hint_Text);
                                              // setState(() {});
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 1, 33, 70),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              width: double.infinity,
                                              height: 40,
                                              child: Center(
                                                  child: Text(
                                                "Done",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              :
                              // ________________________________________________________________________________   (  Add Fields Box  )    _______________________________________________________________________
                              AnimatedContainer(
                                  duration: Duration(microseconds: 100000),
                                  color: Color.fromARGB(255, 83, 83, 83),
                                  // color: Color.fromARGB(255, 226, 171, 138),
                                  // color: Color.fromARGB(255, 154, 164, 168),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: double.infinity,
                                                // color: Colors.amber,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    //_______________________________________________________________________________  (add text)  ________________________________________
                                                    GestureDetector(
                                                      onTap: () {
                                                        Filds_Name!.add("Text");
                                                        int Filds_Name_Length =
                                                            Filds_Name!.length;

                                                        Add_Hint_Lable(
                                                            L: "Text",
                                                            H: " enter your text"); // add hint and lable text

                                                        Add_Fields!(
                                                            field: Filds_Name![
                                                                Filds_Name_Length -
                                                                    1],
                                                            index_of_H_L:
                                                                Filds_Name_Length -
                                                                    1);
                                                        // =================================

                                                        setState(() {});
                                                        print(
                                                            Filds_Name_Length -
                                                                1);
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        width: 160,
                                                        decoration: BoxDecoration(
                                                            color: orange_color,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  blurRadius: 3,
                                                                  offset:
                                                                      Offset(
                                                                          0, 3))
                                                            ]
                                                            // border: Border.all(),
                                                            ),
                                                        child: Center(
                                                          child: Text(
                                                            "Text",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    //_______________________________________________________________________________  (add Date)  ________________________________________
                                                    GestureDetector(
                                                      onTap: () {
                                                        Filds_Name!.add("Date");
                                                        int Filds_Name_Length =
                                                            Filds_Name!.length;
                                                        Add_Hint_Lable(
                                                            L: "Date",
                                                            H: "DD/MM/YYYY"); // add hint and lable text

                                                        // Leble_Text.add(
                                                        //     "value1111");
                                                        // Hint_Text.add(
                                                        //     "DD/MM/YYYY");

                                                        Add_Fields(
                                                            field: Filds_Name![
                                                                Filds_Name_Length -
                                                                    1],
                                                            index_of_H_L:
                                                                Filds_Name_Length -
                                                                    1);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        width: 160,
                                                        decoration: BoxDecoration(
                                                            color: orange_color,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .black,
                                                                  blurRadius: 3,
                                                                  offset:
                                                                      Offset(
                                                                          0, 3))
                                                            ]
                                                            // border: Border.all(),
                                                            ),
                                                        child: Center(
                                                          child: Text("Date",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255))),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 50,
                                                width: double.infinity,
                                                // color: Colors.amber,

                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    //_______________________________________________________________________________  (add text Area)  ________________________________________
                                                    GestureDetector(
                                                      onTap: () {
                                                        Filds_Name!
                                                            .add("Text Area");
                                                        int Filds_Name_Length =
                                                            Filds_Name!.length;

                                                        Add_Hint_Lable!(
                                                            L: "Text Area",
                                                            H: " enter your text area"); // add hint and lable text

                                                        Add_Fields(
                                                            field: Filds_Name![
                                                                Filds_Name_Length -
                                                                    1],
                                                            index_of_H_L:
                                                                Filds_Name_Length -
                                                                    1);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        width: 160,
                                                        decoration: BoxDecoration(
                                                            color: orange_color,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .black,
                                                                  blurRadius: 3,
                                                                  offset:
                                                                      Offset(
                                                                          0, 3))
                                                            ]
                                                            // border: Border.all(),
                                                            ),
                                                        child: Center(
                                                          child: Text(
                                                              "Text area",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255))),
                                                        ),
                                                      ),
                                                    ),
                                                    //_______________________________________________________________________________  (add Number)  ________________________________________
                                                    GestureDetector(
                                                      onTap: () {
                                                        Filds_Name!.add("Num");
                                                        int Filds_Name_Length =
                                                            Filds_Name!.length;

                                                        Add_Hint_Lable(
                                                            L: "Num",
                                                            H: "enter number"); // add hint and lable text

                                                        Add_Fields(
                                                            field: Filds_Name![
                                                                Filds_Name_Length -
                                                                    1],
                                                            index_of_H_L:
                                                                Filds_Name_Length -
                                                                    1);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        width: 160,
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    orange_color,
                                                                borderRadius: BorderRadius.circular(10),
                                                                // border: Border.all(),

                                                                boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .black,
                                                                  blurRadius: 3,
                                                                  offset:
                                                                      Offset(
                                                                          0, 3))
                                                            ]),
                                                        child: Center(
                                                          child: Text("Num",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255))),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 50,
                                                width: double.infinity,
                                                // color: Colors.amber,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    //_______________________________________________________________________________  (add Mobile no)  ________________________________________
                                                    GestureDetector(
                                                      onTap: () {
                                                        Filds_Name!
                                                            .add("Mobile No");
                                                        int Filds_Name_Length =
                                                            Filds_Name!.length;

                                                        Add_Hint_Lable(
                                                            L: "Mobile No",
                                                            H: "enter your mobile number"); // add hint and lable text

                                                        Add_Fields(
                                                            field: Filds_Name![
                                                                Filds_Name_Length -
                                                                    1],
                                                            index_of_H_L:
                                                                Filds_Name_Length -
                                                                    1);

                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        width: 160,
                                                        decoration: BoxDecoration(
                                                            color: orange_color,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .black,
                                                                  blurRadius: 3,
                                                                  offset:
                                                                      Offset(
                                                                          0, 3))
                                                            ]
                                                            // border: Border.all(),
                                                            ),
                                                        child: Center(
                                                          child: Text(
                                                              "Mobile No",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255))),
                                                        ),
                                                      ),
                                                    ),
                                                    //_______________________________________________________________________________  (add Drop Down)  ________________________________________
                                                    // GestureDetector(
                                                    //   onTap: () {
                                                    //     widget.Filds_Name!.add("Drop Down");
                                                    //     int Filds_Name_Length =
                                                    //         widget.Filds_Name!.length;

                                                    //     Add_Hint_Lable(); // add hint and lable text

                                                    //     Add_Fields(
                                                    //         field: widget.Filds_Name![
                                                    //             Filds_Name_Length - 1],
                                                    //         index_of_H_L:
                                                    //             Filds_Name_Length - 1);
                                                    //     setState(() {});
                                                    //   },
                                                    //   child: Container(
                                                    //     height: 50,
                                                    //     width: 160,
                                                    //     decoration: BoxDecoration(
                                                    //       color: Colors.white,
                                                    //       borderRadius:
                                                    //           BorderRadius.circular(10),
                                                    //       border: Border.all(),
                                                    //     ),
                                                    //     child: Center(
                                                    //       child: Text("Drop Down"),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  height: value.Height_Of_Container,
                                  width: double.infinity,
                                ),

                          Container(
                            height: 2,
                            width: double.infinity,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          // __________________________________________________________________________   (Pull Icon)   ______________________________________________________________________
                          Container(
                            padding: EdgeInsets.only(top: 0),
                            // color: Colors.amber,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (value.Height_Of_Container == 70) {
                                        value.Update_Container_Height(190);
                                      } else {
                                        value.Update_Container_Height(70);
                                      }
                                      // height_Of_Container =
                                      //     height_Of_Container == 70 ? 190 : 70;
                                      // setState(() {});

                                      print("object");
                                    },
                                    icon: Icon(
                                      value.Height_Of_Container == 70
                                          ? Icons.arrow_drop_down_outlined
                                          : Icons.arrow_drop_up_outlined,
                                      size: 30,
                                      color: value.Edit_Box == true
                                          ? Color.fromARGB(0, 255, 255, 255)
                                          : const Color.fromARGB(255, 0, 0, 0),
                                    )),
                              ],
                            ),
                          ),
                          // __________________________________________________________________________   (Form Build)   ______________________________________________________________________
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              // height: MediaQuery.of(context).size.height - 450,
                              child: GridView.builder(
                                itemCount: Form_Fields.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: Grid_column,
                                  mainAxisExtent: height_of_field,
                                ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      index_Num = index;
                                      value.Update_Edit_Box(true);
                                      // edit_Box = true;
                                      // setState(() {});
                                      print(Leble_Text[index]);
                                      print(index_Num);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: 20, left: 10),

                                      decoration: BoxDecoration(
                                        color: text_fill_color,
                                        border: Border.all(
                                            color: text__enab_border_color),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // height: 20,
                                      margin: EdgeInsets.all(10),

                                      child: AbsorbPointer(
                                        child: Text(Leble_Text[index]),
                                        absorbing: true,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  widget.update == false
                      ? StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("${currrent_user?.uid}")
                              .doc(widget.Form_name)
                              .collection("User_entries")
                              // .orderBy('Index', descending: false)
                              // .where("uid", isEqualTo: current_user?.uid)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                "Something went wrong",
                                style: TextStyle(color: Colors.white),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CupertinoActivityIndicator());
                            }
                            if (snapshot.data!.docs.isEmpty) {
                              return Text(
                                "No data found",
                                style: TextStyle(color: Colors.white),
                              );
                            }
                            if (snapshot != null && snapshot.data != null) {
                              submit_date.clear();
                              submit_time.clear();
                              user_id.clear();
                              index_data.clear();
                              user_values.clear();
                              int length_of_values = snapshot.data!.docs.length;
                              for (int i = 0; i < length_of_values; i++) {
                                List<String> temp = [];
                                var length_of_lable =
                                    int.parse(snapshot.data!.docs[i]["Length"]);
                                for (var j = 0; j < length_of_lable; j++) {
                                  temp.add(
                                      snapshot.data!.docs[i][j.toString()]);
                                }
                                user_values.add(temp);
                                submit_date.add(snapshot.data!.docs[i]["Date"]);
                                submit_time.add(snapshot.data!.docs[i]["Time"]);
                                index_data.add(snapshot.data!.docs[i]["Index"]);
                                user_id.add(snapshot.data!.docs[i].id);
                                print("Doc ID __________ ${user_id}");
                              }
                              print(" user entrys------$user_values");
                              return SizedBox();
                            }
                            return SizedBox();
                          })
                      : SizedBox(),
                ],
              )),
          // backgroundColor: Color.fromARGB(255, 1, 11, 27),
        ));
  }
}

class My_Drawer extends StatefulWidget {
  var Form_name;

  late Function Refresh;
  late Function height_ch;
  My_Drawer(
      {super.key,
      required this.Form_name,
      required this.Refresh,
      required this.height_ch});

  @override
  State<My_Drawer> createState() => _My_DrawerState();
}

class _My_DrawerState extends State<My_Drawer> {
  bool c1 = false, c2 = false, c3 = false, c4 = false;
  var height = 70;
  Color orange_color = Color.fromARGB(255, 255, 81, 0);
  Color button_color = Color.fromARGB(255, 83, 83, 83);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Column(
        children: [
          Container(
            // padding: EdgeInsets.only(left: 10),
            width: double.infinity,
            height: 95,
            decoration: BoxDecoration(color: orange_color, boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 30,
                // offset: Offset(1, 10),
              )
            ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.Form_name,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              // height: 600,
              width: double.infinity,
              margin: EdgeInsets.all(0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: orange_color,
                    child: Center(
                      child: Text(
                        "Number Of Column ",
                        style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          c1 = true;
                          c2 = false;
                          c3 = false;
                          c4 = false;
                          widget.Refresh(1);
                          setState(() {});
                        },
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 3,
                                    offset: Offset(0, 3))
                              ],
                              // border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                              color: c1
                                  ? Color.fromARGB(255, 1, 18, 41)
                                  : button_color),
                          child: Center(
                            child: Text(
                              "1",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          c1 = false;
                          c2 = true;
                          c3 = false;
                          c4 = false;
                          widget.Refresh(2);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 3,
                                    offset: Offset(0, 3))
                              ],
                              // border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                              color: c2
                                  ? Color.fromARGB(255, 41, 20, 1)
                                  : button_color),
                          height: 30,
                          width: 60,
                          child: Center(
                            child: Text(
                              "2",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          c1 = false;
                          c2 = false;
                          c3 = true;
                          c4 = false;
                          widget.Refresh(3);
                          setState(() {});
                        },
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 3,
                                    offset: Offset(0, 3))
                              ],
                              // border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                              color: c3
                                  ? Color.fromARGB(255, 1, 18, 41)
                                  : button_color),
                          child: Center(
                            child: Text(
                              "3",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          c1 = false;
                          c2 = false;
                          c3 = false;
                          c4 = true;
                          widget.Refresh(4);
                          setState(() {});
                        },
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 3,
                                  offset: Offset(0, 3))
                            ],
                            // border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                            color: c4
                                ? Color.fromARGB(255, 1, 18, 41)
                                : button_color,
                          ),
                          child: Center(
                            child: Text(
                              "4",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  /* Container(
                    width: double.infinity,
                    height: 50,
                    color: const Color.fromARGB(255, 1, 11, 27),
                    child: Center(
                      child: Text(
                        "Height Of Column ",
                        style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "H : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        child: TextField(
                          controller:
                              TextEditingController(text: height.toString()),
                          onChanged: (value) {
                            height = int.parse(value);
                            print(height);
                            widget.height_ch(height);
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        height: 30,
                        width: 80,
                      ),
                    ],
                  ),*/
                  Divider(
                    color: Colors.black,
                  ),
                  /* Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 1, 11, 27),
                    ),
                    child: Center(
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
