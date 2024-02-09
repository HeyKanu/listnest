import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_nest2/Data_show.dart';
import 'package:list_nest2/New_Form.dart';
import 'package:list_nest2/services.dart';
import 'package:list_nest2/show_form_provider.dart';
import 'package:provider/provider.dart';

class Show_my_form extends StatefulWidget {
  String? Form_Name;
  String? Doc_Id;
  List<String>? Trash;

  List? User_Data;
  var update;
  var Sum;
  Show_my_form(
      {this.Form_Name,
      this.Doc_Id,
      this.update,
      this.User_Data,
      this.Trash,
      this.Sum});

  @override
  State<Show_my_form> createState() => _Show_my_formState();
}

class _Show_my_formState extends State<Show_my_form> {
  List<Widget> Form_Fields = [];
  List<String> Filds_Name = [];
  List<String> Leble_Text = [];
  List<String> Hint_Text = [];
  List<String> User_entries = [];
  DateTime? Date = DateTime.now();
  // List<String> Trash = [];

  List<TextEditingController> Filds_controllers = [];
  bool? ab = true;
  bool Loader = false;
  User? current_user = FirebaseAuth.instance.currentUser;
  var Form_column;
  int? Doc_Lengths;

  Color text_fill_color = Color.fromARGB(255, 255, 255, 255);
  Color t_color = Color.fromARGB(255, 255, 255, 255);
  Color orange_color = Color.fromARGB(255, 250, 79, 0);
  Color text_hint_color = Color.fromARGB(104, 0, 0, 0);
  Color text__enab_border_color = Color.fromARGB(255, 0, 0, 0);
  Color text__focus_border_color = Color.fromARGB(255, 250, 79, 0);
  Color text_label_color = Color.fromARGB(255, 250, 79, 0);
  Color body_color = Color.fromARGB(255, 255, 239, 230);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
            // forceMaterialTransparency: true,
            backgroundColor: orange_color,
            centerTitle: true,
            title: Text(
              widget.Form_Name.toString(),
              // style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.off(New_Form(
                      Form_name: widget.Form_Name,
                      load: true,
                      Filds_Name_L: Filds_Name,
                      Form_Fields_L: Form_Fields,
                      Hint_Text_L: Hint_Text,
                      Leble_Text_L: Leble_Text,
                      Grid_column_L: Form_column,
                      update: false,
                    ));
                  },
                  icon: Icon(Icons.edit))
            ],
          ),
          body: Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("${current_user?.uid}")
                  .doc(widget.Form_Name)
                  .collection("form_list")
                  .where("UserId", isEqualTo: current_user?.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CupertinoActivityIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Text("No data found");
                }
                if (snapshot != null && snapshot.data != null) {
                  int length_of_lable =
                      int.parse(snapshot.data!.docs[0]["Length"]);
                  Form_column = int.parse(snapshot.data!.docs[1]["Grid"]);
                  Form_Fields.clear();
                  Filds_Name.clear();
                  Leble_Text.clear();
                  Hint_Text.clear();
                  User_entries.clear();
                  for (int j = 0; j < length_of_lable; j++) {
                    Leble_Text.add(snapshot.data!.docs[0][j.toString()]);
                    print(Leble_Text);
                  }
                  for (int j = 0; j < length_of_lable; j++) {
                    Filds_Name.add(snapshot.data!.docs[1][j.toString()]);
                    print(Leble_Text);
                  }
                  for (int j = 0; j < length_of_lable; j++) {
                    Hint_Text.add(snapshot.data!.docs[2][j.toString()]);
                    print(Leble_Text);
                  }

                  for (int i = 0; i < Filds_Name.length; i++) {
                    if (Filds_Name[i] == "Text") {
                      // Filds_controllers.add(TextEditingController());
                      widget.update
                          ? User_entries.add(widget.User_Data![i])
                          : User_entries.add("null");
                      Form_Fields.add(
                        TextFormField(
                          controller: widget.update
                              ? (TextEditingController()
                                ..text = User_entries[i])
                              : TextEditingController(),
                          onChanged: (value) {
                            User_entries.replaceRange(i, i + 1, [value]);
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            hintText: Hint_Text[i],
                            labelText: Leble_Text[i],
                            filled: true,
                            hintStyle: TextStyle(color: text_hint_color),
                            labelStyle: TextStyle(
                              color: text_label_color,
                            ),
                            fillColor: text_fill_color,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: text__focus_border_color),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: text__enab_border_color),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    } else if (Filds_Name[i] == "Date") {
                      widget.update
                          ? User_entries.add(widget.User_Data![i])
                          : User_entries.add("null");
                      // widget.update
                      //     ? User_entries.add(widget.User_Data![i])
                      //     : User_entries.add(
                      //         "${Date!.day}-${Date!.month}-${Date!.year}");

                      Form_Fields.add(
                        // TextFormField(
                        //   keyboardType: TextInputType.datetime,
                        //   controller: widget.update
                        //       ? (TextEditingController()
                        //         ..text = User_entries[i])
                        //       : TextEditingController(),
                        //   onChanged: (value) {
                        //     User_entries.replaceRange(i, i + 1, [value]);
                        //   },
                        //   minLines: 1,
                        //   maxLines: 4,
                        //   decoration: InputDecoration(
                        //     hintText: Hint_Text[i],
                        //     labelText: Leble_Text[i],
                        //     contentPadding: EdgeInsets.only(left: 5),
                        //     filled: true,
                        //     fillColor: Colors.white,
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.white),
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.white),
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        // ),

                        Consumer<S_F_Provider>(
                          builder: (context, value, child) {
                            return InkWell(
                              onTap: () async {
                                DateTime? Selected_Date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2026));
                                if (Selected_Date != null) {
                                  print("object...");
                                  // setState(() {
                                  Date = Selected_Date;
                                  value.Update_Date(true);
                                  User_entries.replaceRange(i, i + 1, [
                                    "${Selected_Date!.day}/${Selected_Date!.month}/${Selected_Date!.year}"
                                  ]);
                                  print(User_entries);
                                  // });
                                }
                                print(
                                    "Date:-  ${Date!.day}/${Date!.month}/${Date!.year}");
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  controller: widget.update
                                      ? (TextEditingController()
                                        ..text = User_entries[i])
                                      : value.Date_Change
                                          ? (TextEditingController()
                                            ..text = User_entries[i])
                                          : (TextEditingController()
                                            ..text = "null"),
                                  minLines: 1,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: Hint_Text[i],
                                    labelText: Leble_Text[i],
                                    contentPadding: EdgeInsets.only(left: 5),
                                    hintStyle:
                                        TextStyle(color: text_hint_color),
                                    labelStyle: TextStyle(
                                      color: text_label_color,
                                    ),
                                    filled: true,
                                    fillColor: text_fill_color,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: text__focus_border_color),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: text__enab_border_color),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),

                                // Container(
                                //   color: Colors.white,
                                //   child: Center(
                                //     child: widget.update
                                //         ? Text(widget.User_Data![i])
                                //         : Text(
                                //             "${Date!.day}-${Date!.month}-${Date!.year}"),
                                //   ),
                                // ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (Filds_Name[i] == "Text Area") {
                      widget.update
                          ? User_entries.add(widget.User_Data![i])
                          : User_entries.add("null");
                      Form_Fields.add(
                        TextFormField(
                          controller: widget.update
                              ? (TextEditingController()
                                ..text = User_entries[i])
                              : TextEditingController(),
                          onChanged: (value) {
                            User_entries.replaceRange(i, i + 1, [value]);
                          },
                          minLines: 1,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: Leble_Text[i],
                            contentPadding: EdgeInsets.only(left: 5),
                            hintStyle: TextStyle(color: text_hint_color),
                            labelStyle: TextStyle(
                              color: text_label_color,
                            ),
                            filled: true,
                            fillColor: text_fill_color,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: text__focus_border_color),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: text__enab_border_color),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    } else if (Filds_Name[i] == "Num") {
                      widget.update
                          ? User_entries.add(widget.User_Data![i])
                          : User_entries.add("null");
                      Form_Fields.add(
                        TextFormField(
                          controller: widget.update
                              ? (TextEditingController()
                                ..text = User_entries[i])
                              : TextEditingController(),
                          onChanged: (value) {
                            User_entries.replaceRange(i, i + 1, [value]);
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            hintText: Hint_Text[i],
                            labelText: Leble_Text[i],
                            hintStyle: TextStyle(color: text_hint_color),
                            labelStyle: TextStyle(
                              color: text_label_color,
                            ),
                            filled: true,
                            fillColor: text_fill_color,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: text__focus_border_color),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: text__enab_border_color),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    } else if (Filds_Name[i] == "Mobile No") {
                      widget.update
                          ? User_entries.add(widget.User_Data![i])
                          : User_entries.add("null");
                      Form_Fields.add(
                        TextFormField(
                          controller: widget.update
                              ? (TextEditingController()
                                ..text = User_entries[i])
                              : TextEditingController(),
                          onChanged: (value) {
                            User_entries.replaceRange(i, i + 1, [value]);
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            hintText: Hint_Text[i],
                            labelText: Leble_Text[i],
                            hintStyle: TextStyle(color: text_hint_color),
                            labelStyle: TextStyle(
                              color: text_label_color,
                            ),
                            filled: true,
                            fillColor: text_fill_color,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: text__focus_border_color),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: text__enab_border_color),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    } else if (Filds_Name[i] == "Drop Down") {
                      User_entries.add("null");
                      Form_Fields.add(DropdownMenu(dropdownMenuEntries: []));
                    }
                  }

                  //-----------------------------------------------------------------------------   Form build    ---------------------------------------------
                  return Container(
                    padding: EdgeInsets.only(top: 5),
                    width: double.infinity,
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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 3, left: 3),
                            child: GridView.builder(
                              itemCount: Form_Fields.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: Form_column,
                                mainAxisExtent: 70,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  // padding: EdgeInsets.all(5),
                                  // color: Colors.white,
                                  height: 20,
                                  margin: EdgeInsets.all(10),
                                  child: Form_Fields[index],
                                );
                              },
                            ),
                          ),
                        ),
                        Loader
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  DateTime entry_date = DateTime.now();
                                  Loader = true;
                                  setState(() {});
                                  Map<String, dynamic> Map_User_entries = {};
                                  for (int i = 0;
                                      i < User_entries.length;
                                      i++) {
                                    Map_User_entries[i.toString()] =
                                        User_entries[i];
                                  }
                                  print(Map_User_entries);
                                  Map_User_entries["Date"] =
                                      "${entry_date.day}/${entry_date.month}/${entry_date.year}";
                                  Map_User_entries["Time"] =
                                      "${entry_date.hour}:${entry_date.minute}:${entry_date.second}";
                                  Map_User_entries["uid"] =
                                      "${current_user?.uid.toString()}";
                                  Map_User_entries["Length"] =
                                      "${User_entries.length}";
                                  Map_User_entries["Index"] = widget.Sum++;
                                  if (widget.update == true) {
                                    print("trueeeeeeeeeeee..........");
                                    await FirebaseFirestore.instance
                                        .collection("${current_user?.uid}")
                                        .doc(widget.Form_Name)
                                        .collection("User_entries")
                                        .doc(widget.Doc_Id.toString())
                                        .set(Map_User_entries);
                                  } else {
                                    await FirebaseFirestore.instance
                                        .collection("${current_user?.uid}")
                                        .doc(widget.Form_Name)
                                        .collection("User_entries")
                                        .doc()
                                        .set(Map_User_entries);
                                  }

                                  if (widget.update == false) {
                                    Map<String, dynamic> Map_Trash = {};
                                    for (int i = 0;
                                        i < widget.Trash!.length;
                                        i++) {
                                      Map_Trash[i.toString()] =
                                          widget.Trash![i];
                                    }
                                    Map_Trash["uid"] =
                                        "${current_user?.uid.toString()}";
                                    Map_Trash["Length"] =
                                        "${widget.Trash!.length}";
                                    Map_Trash["Index"] = 0;
                                    print("Trash ${Map_Trash}");
                                    await FirebaseFirestore.instance
                                        .collection("${current_user?.uid}")
                                        .doc(widget.Form_Name)
                                        .collection("Trash")
                                        .doc("Trash")
                                        .set(Map_Trash);
                                  }
                                  Loader = false;
                                  setState(() {});
                                  print(User_entries);
                                  if (widget.update == true) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                  // Get.off(Data_show(
                                  //   Form_name: widget.Form_Name,
                                  // ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: orange_color,
                                  ),
                                  margin: EdgeInsets.all(20),
                                  height: 50,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          )),
    );
  }
}
