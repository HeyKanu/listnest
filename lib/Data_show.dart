import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:list_nest2/Filter_provider.dart';
import './Export.dart';

import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:dropdown_button3/src/dropdown_button3.dart';

import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './show_form.dart';
import './full_data.dart';
import './my_providers.dart';

class Data_show extends StatefulWidget {
  String? Form_name;
  Data_show({this.Form_name});

  @override
  State<Data_show> createState() => _Data_showState();
}

class _Data_showState extends State<Data_show> {
  List<String> Lables = [];
  List<String> Trash = [];
  List<String> Doc_Ids = [];
  List<String> Filds_Name = [];
  List<String> Submit_Date = [];
  var values = <List<String>>[];
  List<int> INDEX = [];
  String? extract_formet = "pdf";

  String Date_select = "Submit Date";
  String? Value_select;
  String? Short_By_Select = "Old";
  List<DataColumn> my_columns = [];
  List<PopupMenuItem> MenuItems = [];
  bool Filter = false;
  var file_con = TextEditingController();
  var pdf_file_con = TextEditingController();

  DateTime? defoult_Date = DateTime.now();
  DateTime? defoult_stsrt_Date = DateTime.now();
  DateTime? defoult_end_Date = DateTime.now();

  String? Value_greater = "Greater";
  String? Date_Greater = "Greater";
  bool Date_Range = false;
  bool Value_Range = false;
  bool Filter_Value = false;
  // List<DataRow> my_row = [];
  final List<String> Date_Fild = ["Submit Date"];
  final List<int> Date_Fild_ind = [];
  final List<String> Value_Fild = [];
  final List<String> Short_By = [
    "Oldest", "Latest"
    // , "Ascending", "Descending"
  ];
  final List<int> Value_Fild_ind = [];

  TextEditingController Date_Controll = TextEditingController();
  TextEditingController Start_Date_Controll = TextEditingController();
  TextEditingController End_Date_Controll = TextEditingController();
  TextEditingController Value_Controll = TextEditingController();
  TextEditingController Start_Value_Controll = TextEditingController();
  TextEditingController End_Value_Controll = TextEditingController();

  String? _selectedValue;
  var ind;
  int length_of_lable = 0;
  var length_of_entries;
  User? current_user = FirebaseAuth.instance.currentUser;
  var search_control = TextEditingController();

  bool search = false;
  bool a = true;
  bool delete = false;
  bool xyz = false;
  bool abc = false;
  int Sum = 2;
  List<List> search_values = [];
  int search_index = 0;
  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Lables.clear();
    values.clear();
    my_columns.clear();
  }

  void search_filter(String element) {
    if (element.isEmpty) {
      search_values.clear();
      for (int i = 0; i < values.length; i++) {
        search_values.add(values[i]);
      }
      // search_results = Form_names;
    } else {
      search_values.clear();
      for (int i = 0; i < values.length; i++) {
        print("I=" + i.toString());
        if (values[i][search_index]
            .toLowerCase()
            .startsWith(element.toLowerCase())) {
          search_values.add(values[i]);
        }
      }
    }

    // print("search r $search_results");
  }

  Color text_fill_color = Color.fromARGB(255, 255, 255, 255);
  Color t_color = Color.fromARGB(255, 255, 239, 230);
  Color orange_color = Color.fromARGB(255, 250, 79, 0);
  Color text_hint_color = Color.fromARGB(104, 0, 0, 0);
  Color text__enab_border_color = Color.fromARGB(255, 0, 0, 0);
  Color text__focus_border_color = Color.fromARGB(255, 4, 142, 255);
  Color text_label_color = Color.fromARGB(255, 0, 0, 0);
  Color body_color = Color.fromARGB(255, 255, 255, 255);
  // Color body_color = Color.fromARGB(255, 255, 239, 230);

  @override
  Widget build(BuildContext context) {
    final provider_object = Provider.of<my_providers>(context, listen: false);
    final Filter_provider_object =
        Provider.of<F_provider>(context, listen: false);

    return WillPopScope(onWillPop: () {
      if (delete) {
        delete = false;

        setState(() {});
        return Future.value(false);
      }
      if (Filter) {
        Filter = false;

        Filter_provider_object.Update_Selected_Value_Date("");
        // Selected_Value_Dat
        setState(() {});
        return Future.value(false);
      }
      return Future.value(true);
    }, child: Consumer<my_providers>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          // forceMaterialTransparency: true,
          backgroundColor: orange_color,
          centerTitle: true,
          // automaticallyImplyLeading: false,
          title: delete
              ? Text("Trash")
              : Filter
                  ? Text("Filter")
                  : Text(
                      widget.Form_name.toString(),
                      // style: TextStyle(color: Colors.black),
                    ),
          leading: delete || Filter
              ? Container(
                  child: InkWell(
                    child: Icon(
                      Icons.close,
                    ),
                    onTap: () {
                      delete = false;
                      Filter = false;
                      setState(() {});
                    },
                  ),
                  margin: EdgeInsets.only(left: 20),
                )
              : SizedBox(),
          actions: [
            search
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.blueAccent,
                    ),
                    color: Color.fromARGB(255, 56, 56, 56),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    itemBuilder: (context) {
                      return MenuItems;
                    },
                  )
                : SizedBox(),
            AnimatedContainer(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                width: search ? 260 : 45,
                // height: 10,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(80)),
                duration: Duration(milliseconds: 200),
                child: search
                    ? TextField(
                        controller: search_control..text.isEmpty,
                        onChanged: (value) {
                          a = false;
                          print(value);
                          search_filter(value);
                          setState(() {});
                        },
                        autocorrect: true,
                        autofocus: true,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                onPressed: () {
                                  search = false;
                                  a = true;
                                  search_control.clear();
                                  setState(() {});
                                },
                                icon: Icon(Icons.close)),
                            hintText: " Search ",
                            contentPadding: EdgeInsets.only(left: 10),
                            suffixIcon: Icon(Icons.search),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(80))),
                      )
                    : InkWell(
                        onTap: () {
                          search = true;

                          setState(() {});
                        },
                        child: Icon(
                          Icons.search,
                          color: const Color.fromARGB(172, 0, 0, 0),
                        ),
                      )),
            Consumer<F_provider>(
              builder: (context, value, child) {
                return PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  color: Color.fromARGB(255, 56, 56, 56),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          child: ListTile(
                            leading: Icon(
                              Icons.delete,
                              color: Color.fromARGB(132, 255, 255, 255),
                            ),
                            title: Text(
                              "Trash",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          value: "Trash",
                          onTap: () {
                            delete = true;
                            Filter = false;
                            setState(() {});
                          }),
                      PopupMenuItem(
                        onTap: () {
                          Filter = true;
                          delete = false;
                          Date_Fild.clear();
                          Date_Fild.add("Submit Date");
                          Value_Fild.clear();

                          for (var i = 0; i < Date_Fild_ind.length; i++) {
                            Date_Fild.add(Lables[Date_Fild_ind[i]]);
                          }
                          for (var i = 0; i < Value_Fild_ind.length; i++) {
                            Value_Fild.add(Lables[Value_Fild_ind[i]]);
                          }
                          value.Update_Selected_Value_Date(Date_Fild[0]);

                          print(Date_Fild);
                          print("----------------------------++++++");
                          print(Value_Fild);
                          setState(() {});
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.tune,
                            color: Color.fromARGB(148, 255, 255, 255),
                          ),
                          title: Text(
                            "Filter",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        value: "Filter",
                      ),
                      PopupMenuItem(
                        onTap: () async {
                          Get.defaultDialog(
                            title: "Extract To Excel ",
                            // actions: [
                            //   Radio(

                            //     value: "excel",
                            //     groupValue: "formet",
                            //     onChanged: (value) {
                            //       extract_formet = value;
                            //     },
                            //   ),
                            //   Radio(
                            //     value: "pdf",
                            //     groupValue: "formet",
                            //     onChanged: (value) {
                            //       extract_formet = value;
                            //     },
                            //   )
                            // ],
                            content: Container(
                                height: 50,
                                width: 200,
                                child: TextFormField(
                                  controller: file_con,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 0, 150, 250))),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 0, 150, 250))),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 250, 0, 0))),
                                      hintText: "enter file name to save",
                                      focusedBorder:
                                          OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color.fromARGB(255, 0, 150, 250)))),
                                )),
                            cancel: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                child: Center(child: Text("Cancel")),
                              ),
                            ),
                            confirm: InkWell(
                              onTap: () async {
                                print("valid");
                                Export_To_Excel obj = Export_To_Excel();
                                PermissionStatus storage_per =
                                    await Permission.storage.request();
                                if (storage_per == PermissionStatus.granted) {
                                  if (search_control.text.isEmpty ||
                                      search == false) {
                                    obj.export_to_Excel(
                                        file_con.text, values, Lables);
                                  } else if (search_control.text.isNotEmpty ||
                                      search == true) {
                                    obj.export_to_Excel(
                                        file_con.text, search_values, Lables);
                                  }
                                  // search
                                  //     ? obj.export_to_Excel(
                                  //         file_con.text, search_values, Lables)
                                  //     : obj.export_to_Excel(
                                  //         file_con.text, values, Lables);

                                  // Get.snackbar(
                                  //     "Error", "Samthing went wrong");
                                }
                                if (storage_per == PermissionStatus.denied) {
                                  await Permission.storage.request();
                                  // openAppSettings();
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(SnackBar(
                                        content: Text(
                                            "This permission is recommended")));
                                }
                                if (storage_per ==
                                    PermissionStatus.permanentlyDenied) {
                                  // openAppSettings();
                                  openAppSettings();
                                }
                                file_con.clear();
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                child: Center(child: Text("Extract")),
                              ),
                            ),
                          );
                          // Export_To_Excel obj = Export_To_Excel();
                          // PermissionStatus storage_per =
                          //     await Permission.storage.request();
                          // if (storage_per == PermissionStatus.granted) {

                          //     obj.export_to_Excel(
                          //         "my excel file", values, Lables);

                          //     // Get.snackbar(
                          //     //     "Error", "Samthing went wrong");

                          // }
                          // if (storage_per == PermissionStatus.denied) {
                          //   await Permission.storage.request();
                          //   // openAppSettings();
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //           content: Text(
                          //               "This permission is recommended")));
                          // }
                          // if (storage_per ==
                          //     PermissionStatus.permanentlyDenied) {
                          //   // openAppSettings();
                          //   openAppSettings();
                          // }
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.import_export,
                            color: Color.fromARGB(148, 255, 255, 255),
                          ),
                          title: Text(
                            "Extract to xlsx",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        value: "Export",
                      ),
                      PopupMenuItem(
                        onTap: () async {
                          Get.defaultDialog(
                            title: "Extract To Pdf ",
                            content: Container(
                                height: 50,
                                width: 200,
                                child: TextFormField(
                                  controller: pdf_file_con,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 0, 150, 250))),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 0, 150, 250))),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 250, 0, 0))),
                                      hintText: "enter file name to save",
                                      focusedBorder:
                                          OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color.fromARGB(255, 0, 150, 250)))),
                                )),
                            cancel: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                child: Center(child: Text("Cancel")),
                              ),
                            ),
                            confirm: InkWell(
                              onTap: () async {
                                print("valid");
                                var obj = Export_To_PDf();
                                PermissionStatus storage_per =
                                    await Permission.storage.request();
                                if (storage_per == PermissionStatus.granted) {
                                  if (search_control.text.isEmpty ||
                                      search == false) {
                                    obj.export_to_pdf(Lables, widget.Form_name,
                                        values, pdf_file_con.text);
                                  } else if (search_control.text.isNotEmpty ||
                                      search == true) {
                                    obj.export_to_pdf(Lables, widget.Form_name,
                                        search_values, pdf_file_con.text);
                                  }
                                }
                                if (storage_per == PermissionStatus.denied) {
                                  await Permission.storage.request();
                                  // openAppSettings();
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(SnackBar(
                                        content: Text(
                                            "This permission is recommended")));
                                }
                                if (storage_per ==
                                    PermissionStatus.permanentlyDenied) {
                                  // openAppSettings();
                                  openAppSettings();
                                }
                                pdf_file_con.clear();
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                child: Center(child: Text("Extract")),
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.import_export,
                            color: Color.fromARGB(148, 255, 255, 255),
                          ),
                          title: Text(
                            "Extract To Pdf",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        value: "Pdf",
                      ),
                    ];
                  },
                );
              },
            )
          ],
        ),
        floatingActionButton: delete
            ? SizedBox()
            : Filter
                ? SizedBox()
                : FloatingActionButton(
                    onPressed: () {
                      print("..................$Sum");
                      Get.to(Show_my_form(
                        Form_Name: widget.Form_name,
                        Trash: Trash,
                        update: false,
                        Sum: Sum,
                      ));
                    },
                    backgroundColor: orange_color,
                    child: Icon(
                      Icons.add,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
        body: Container(
            padding: EdgeInsets.only(top: 10),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // StreamBuilder(
                //   stream: FirebaseFirestore.instance
                //       .collection("${current_user?.uid}")
                //       .doc(widget.Form_name)
                //       .collection("form_list")
                //       .where("UserId", isEqualTo: current_user?.uid)
                //       .snapshots(),
                //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return Center(child: CupertinoActivityIndicator());
                //     }
                //     if (snapshot.data!.docs.isEmpty) {
                //       return Text("No data found");
                //     }
                //     if (snapshot != null && snapshot.data != null) {}
                //     return SizedBox();
                //   },
                // ),
                Consumer(builder: (context, value, child) {
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(current_user!.uid)
                        .doc(widget.Form_name)
                        .collection("Trash")
                        // .where("uid", isEqualTo: current_user?.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      // if (snapshot.data!.docs.isEmpty) {
                      //   return Text("No data found");
                      // }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: SizedBox());
                      }
                      if (snapshot != null && snapshot.data != null) {
                        print(
                            "Innnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn.........................");
                        int length_of_Trash = 0;
                        try {
                          length_of_Trash =
                              int.parse(snapshot.data!.docs[0]["Length"]);
                        } catch (error) {
                          print(error);
                          return SizedBox();
                        }
                        Trash.clear();

                        for (var i = 0; i < length_of_Trash; i++) {
                          Trash.add(snapshot.data!.docs[0][i.toString()]);
                        }
                        print(Trash);
                        // ---------------------------------------------------------------------------- (Store trash data in firebase )
                        // if (provider_object.Delete) {
                        //   Map<String, String> map_Trash = {};

                        //   for (int i = 0; i < Trash.length; i++) {
                        //     map_Trash[i.toString()] = Trash[i];
                        //   }
                        //   map_Trash["Length"] = Trash.length.toString();
                        //   map_Trash["userId"] = current_user!.uid.toString();
                        //   FirebaseFirestore.instance
                        //       .collection(current_user!.uid)
                        //       .doc(widget.Form_name)
                        //       .collection("Trash")
                        //       .doc("Trash")
                        //       .set(map_Trash);
                        //   // provider_object.set_Delete(false);

                        //   return SizedBox();
                        // }

                        return SizedBox();
                      }
                      return SizedBox();
                    },
                  );
                }),

                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("${current_user?.uid}")
                        .doc(widget.Form_name)
                        .collection("form_list")
                        // .where("UserId", isEqualTo: current_user?.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: SizedBox());
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Text("No data found");
                      }
                      if (snapshot != null && snapshot.data != null) {
                        // snapshot.data!.docs[0] [];
                        length_of_lable =
                            int.parse(snapshot.data!.docs[0]["Length"]);
                        print("Label Length= $length_of_lable");
                        // int Form_column =
                        //     int.parse(snapshot.data!.docs[1]["Grid"]);
                        Lables.clear();
                        MenuItems.clear();
                        Filds_Name.clear();
                        Value_Fild_ind.clear();
                        Date_Fild_ind.clear();
                        for (int j = 0; j < length_of_lable; j++) {
                          Filds_Name.add(snapshot.data!.docs[1][j.toString()]);
                          if (snapshot.data!.docs[1][j.toString()] == "Date") {
                            Date_Fild_ind.add(j);
                          }
                          if (snapshot.data!.docs[1][j.toString()] == "Num") {
                            Value_Fild_ind.add(j);
                          }
                          // print(Leble_Text);
                        }

                        for (int j = 0; j < length_of_lable; j++) {
                          Lables.add(snapshot.data!.docs[0][j.toString()]);
                          MenuItems.add(
                            PopupMenuItem(
                              child: ListTile(
                                onTap: () {
                                  search_index = j;
                                  Navigator.pop(context);
                                },
                                leading: Icon(
                                  Icons.label,
                                  color: const Color.fromARGB(255, 255, 98, 98),
                                ),
                                title: Text(
                                  "${snapshot.data!.docs[0][j.toString()]}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                          print(Lables);
                        }
                        return SizedBox();
                      }
                      return SizedBox();
                    }),

                // ____________________________________________________________________________   (Filter)  ______________________________________________
                Filter
                    ? Consumer<F_provider>(
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                width: MediaQuery.of(context).size.width,
                                height: value.Height_Of_Container,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 255, 85, 7),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                value.Update_Date_active(true);
                                                Filter_Value = false;
                                                setState(() {});
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 148,
                                                margin: EdgeInsets.only(top: 2),
                                                decoration: BoxDecoration(
                                                    color: value.Date_active
                                                        ? const Color.fromARGB(
                                                            255, 255, 255, 255)
                                                        : const Color.fromARGB(
                                                            255, 255, 85, 7),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Center(
                                                    child: Text(
                                                  "Date",
                                                  style: TextStyle(
                                                      color: value.Date_active
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                value.Update_Date_active(false);

                                                Filter_Value = true;
                                                Value_select = Value_Fild[0];
                                                value
                                                    .Update_Selected_Value_Value(
                                                        Value_Fild[0]);
                                                setState(() {});
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 148,
                                                margin: EdgeInsets.only(top: 2),
                                                decoration: BoxDecoration(
                                                    // color: Color.fromARGB(255, 255, 255, 255),
                                                    color: value.Date_active
                                                        ? const Color.fromARGB(
                                                            255, 255, 85, 7)
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Center(
                                                    child: Text(
                                                  "Value",
                                                  style: TextStyle(
                                                      color: value.Date_active
                                                          ? Colors.white
                                                          : const Color
                                                              .fromARGB(
                                                              255, 5, 5, 5),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      value.Date_active
                                          // --------------------------------------------------   (Date controlers)
                                          ? Container(
                                              width: double.infinity,
                                              height: 250,
                                              color: Colors.transparent,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 150,
                                                        // height: 50,
                                                        margin: EdgeInsets.only(
                                                            left: 5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: const Color
                                                                .fromARGB(255,
                                                                165, 165, 165)),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2(
                                                            isExpanded: true,
                                                            hint: Row(
                                                              children: const [
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    'Select Column',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            items: Date_Fild
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          item,
                                                                      child:
                                                                          Text(
                                                                        item,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    )).toList(),
                                                            value: value
                                                                .Selected_Value_Date,
                                                            onChanged: (val) {
                                                              print("object");

                                                              Date_select = val
                                                                  .toString();
                                                              print(
                                                                  Date_select);
                                                              value
                                                                  .Update_Selected_Value_Date(
                                                                      val);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Range ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: value.Range
                                                                      ? Colors
                                                                          .black
                                                                      : Color.fromARGB(
                                                                          134,
                                                                          2,
                                                                          2,
                                                                          2)),
                                                            ),
                                                            Switch(
                                                              value:
                                                                  value.Range,
                                                              onChanged: (ab) {
                                                                Date_Range = ab;
                                                                // setState(() {});
                                                                value
                                                                    .Update_Range(
                                                                        ab);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  value.Range
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                              width: 150,
                                                              height: 50,
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  DateTime? Selected_Date = await showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          DateTime
                                                                              .now(),
                                                                      firstDate:
                                                                          DateTime(
                                                                              2000),
                                                                      lastDate:
                                                                          DateTime(
                                                                              2026));
                                                                  if (Selected_Date !=
                                                                      null) {
                                                                    print(
                                                                        "object...");
                                                                    // setState(() {
                                                                    defoult_stsrt_Date =
                                                                        Selected_Date;
                                                                    value.Update_Date(
                                                                        true);
                                                                    // User_entries.replaceRange(i, i + 1, [
                                                                    //   "${Selected_Date!.day}/${Selected_Date!.month}/${Selected_Date!.year}"
                                                                    // ]);
                                                                    // print(
                                                                    //     User_entries);
                                                                    // });
                                                                  }
                                                                  // print(
                                                                  //     "Date:-  ${Date!.day}-${Date!.month}-${Date!.year}");
                                                                },
                                                                child:
                                                                    AbsorbPointer(
                                                                  child:
                                                                      TextFormField(
                                                                    controller: value
                                                                            .Date_Change
                                                                        ? (Start_Date_Controll
                                                                          ..text =
                                                                              "${defoult_stsrt_Date!.day}/${defoult_stsrt_Date!.month}/${defoult_stsrt_Date!.year}")
                                                                        : (Start_Date_Controll
                                                                          ..text =
                                                                              "${defoult_stsrt_Date!.day}/${defoult_stsrt_Date!.month}/${defoult_stsrt_Date!.year}"),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .datetime,
                                                                    decoration: InputDecoration(
                                                                        labelText:
                                                                            "Date",
                                                                        contentPadding: EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                        enabledBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                5)),
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            borderSide: BorderSide(color: Colors.blueAccent))),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Text("To"),
                                                            Container(
                                                              width: 150,
                                                              height: 50,
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  DateTime? Selected_Date = await showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          DateTime
                                                                              .now(),
                                                                      firstDate:
                                                                          DateTime(
                                                                              2000),
                                                                      lastDate:
                                                                          DateTime(
                                                                              2026));
                                                                  if (Selected_Date !=
                                                                      null) {
                                                                    print(
                                                                        "object...");
                                                                    // setState(() {
                                                                    defoult_end_Date =
                                                                        Selected_Date;
                                                                    value.Update_Date(
                                                                        true);
                                                                    // User_entries.replaceRange(i, i + 1, [
                                                                    //   "${Selected_Date!.day}/${Selected_Date!.month}/${Selected_Date!.year}"
                                                                    // ]);
                                                                    // print(
                                                                    //     User_entries);
                                                                    // });
                                                                  }
                                                                  // print(
                                                                  //     "Date:-  ${Date!.day}-${Date!.month}-${Date!.year}");
                                                                },
                                                                child:
                                                                    AbsorbPointer(
                                                                  child:
                                                                      TextFormField(
                                                                    controller: value
                                                                            .Date_Change
                                                                        ? (End_Date_Controll
                                                                          ..text =
                                                                              "${defoult_end_Date!.day}/${defoult_end_Date!.month}/${defoult_end_Date!.year}")
                                                                        : (End_Date_Controll
                                                                          ..text =
                                                                              "${defoult_end_Date!.day}/${defoult_end_Date!.month}/${defoult_end_Date!.year}"),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .datetime,
                                                                    decoration: InputDecoration(
                                                                        labelText:
                                                                            "Date",
                                                                        contentPadding: EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                        enabledBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                5)),
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            borderSide: BorderSide(color: Colors.blueAccent))),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 150,
                                                              height: 50,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          20),
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  DateTime? Selected_Date = await showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          DateTime
                                                                              .now(),
                                                                      firstDate:
                                                                          DateTime(
                                                                              2000),
                                                                      lastDate:
                                                                          DateTime(
                                                                              2026));
                                                                  if (Selected_Date !=
                                                                      null) {
                                                                    print(
                                                                        "object...");
                                                                    // setState(() {
                                                                    defoult_Date =
                                                                        Selected_Date;
                                                                    value.Update_Date(
                                                                        true);
                                                                    // User_entries.replaceRange(i, i + 1, [
                                                                    //   "${Selected_Date!.day}/${Selected_Date!.month}/${Selected_Date!.year}"
                                                                    // ]);
                                                                    // print(
                                                                    //     User_entries);
                                                                    // });
                                                                  }
                                                                  // print(
                                                                  //     "Date:-  ${Date!.day}-${Date!.month}-${Date!.year}");
                                                                },
                                                                child:
                                                                    AbsorbPointer(
                                                                  child:
                                                                      TextFormField(
                                                                    controller: value
                                                                            .Date_Change
                                                                        ? (Date_Controll
                                                                          ..text =
                                                                              "${defoult_Date!.day}/${defoult_Date!.month}/${defoult_Date!.year}")
                                                                        : (Date_Controll
                                                                          ..text =
                                                                              "${defoult_Date!.day}/${defoult_Date!.month}/${defoult_Date!.year}"),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .datetime,
                                                                    decoration: InputDecoration(
                                                                        labelText:
                                                                            "Date",
                                                                        contentPadding: EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                        enabledBorder: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                5)),
                                                                        focusedBorder: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            borderSide: BorderSide(color: Colors.blueAccent))),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              margin: EdgeInsets
                                                                  .only(),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      85,
                                                                      7)),
                                                              // color: const Color.fromARGB(255, 255, 255, 255),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Radio(
                                                                        activeColor:
                                                                            Colors.cyanAccent,
                                                                        value:
                                                                            "Greater",
                                                                        groupValue:
                                                                            value.Current_option,
                                                                        onChanged:
                                                                            (abc) {
                                                                          Date_Greater =
                                                                              abc;
                                                                          value.Update_Curent_Option(
                                                                              abc.toString());
                                                                          print(
                                                                              value.Current_option);
                                                                        },
                                                                      ),
                                                                      Text(
                                                                        "Greater",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Radio(
                                                                        activeColor:
                                                                            Colors.cyanAccent,
                                                                        value:
                                                                            "Less",
                                                                        groupValue:
                                                                            value.Current_option,
                                                                        onChanged:
                                                                            (abc) {
                                                                          Date_Greater =
                                                                              abc;
                                                                          value.Update_Curent_Option(
                                                                              abc.toString());
                                                                          print(
                                                                              value.Current_option);
                                                                        },
                                                                      ),
                                                                      Text(
                                                                        "Less",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print("object");
                                                      print(Submit_Date);

                                                      FocusScopeNode
                                                          currentFocus =
                                                          FocusScope.of(
                                                              context);

                                                      if (!currentFocus
                                                          .hasPrimaryFocus) {
                                                        currentFocus.unfocus();
                                                      }
                                                      value.Update_Height(0.0);
                                                      value.Update_Icon(Icon(
                                                        Icons
                                                            .arrow_drop_down_outlined,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 0, 0, 0),
                                                        size: 50,
                                                      ));
                                                      xyz = true;
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black,
                                                                blurRadius: 5,
                                                                offset: Offset(
                                                                    0, 0))
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 255, 85, 7)),
                                                      child: Center(
                                                          child: Text(
                                                        "Done",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : // --------------------------------------------------   (Value controlers)
                                          Container(
                                              width: double.infinity,
                                              height: 250,
                                              color: Colors.transparent,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 150,
                                                        // height: 50,
                                                        margin: EdgeInsets.only(
                                                            left: 5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: const Color
                                                                .fromARGB(255,
                                                                165, 165, 165)),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2(
                                                            isExpanded: true,
                                                            hint: Row(
                                                              children: const [
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    'Select Column',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            items: Value_Fild
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          item,
                                                                      child:
                                                                          Text(
                                                                        item,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    )).toList(),
                                                            value: value
                                                                .Selected_Value_Value,
                                                            onChanged: (val) {
                                                              // _selectedValue =
                                                              //     value;
                                                              Value_select = val
                                                                  .toString();
                                                              value
                                                                  .Update_Selected_Value_Value(
                                                                      val);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Range ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: value.Range
                                                                      ? Colors
                                                                          .black
                                                                      : Color.fromARGB(
                                                                          134,
                                                                          2,
                                                                          2,
                                                                          2)),
                                                            ),
                                                            Switch(
                                                              value:
                                                                  value.Range,
                                                              onChanged: (ab) {
                                                                Value_Range =
                                                                    ab;
                                                                value
                                                                    .Update_Range(
                                                                        ab);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  value.Range
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                              width: 150,
                                                              height: 50,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    Start_Value_Controll,
                                                                onChanged:
                                                                    (value) {},
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration: InputDecoration(
                                                                    labelText:
                                                                        "Value 1",
                                                                    hintText:
                                                                        "Starting Vale",
                                                                    contentPadding:
                                                                        EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(
                                                                            5)),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        borderSide:
                                                                            BorderSide(color: Colors.blueAccent))),
                                                              ),
                                                            ),
                                                            Text("To"),
                                                            Container(
                                                              width: 150,
                                                              height: 50,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    End_Value_Controll,
                                                                onChanged:
                                                                    (value) {},
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration: InputDecoration(
                                                                    labelText:
                                                                        "Value 2",
                                                                    hintText:
                                                                        "Ending Value",
                                                                    contentPadding:
                                                                        EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(
                                                                            5)),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        borderSide:
                                                                            BorderSide(color: Colors.blueAccent))),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 150,
                                                              height: 50,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          20),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    Value_Controll,
                                                                onChanged:
                                                                    (val) {},
                                                                keyboardType:
                                                                    TextInputType
                                                                        .datetime,
                                                                decoration: InputDecoration(
                                                                    labelText:
                                                                        "Value",
                                                                    hintText:
                                                                        "Enter value",
                                                                    contentPadding:
                                                                        EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(
                                                                            5)),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        borderSide:
                                                                            BorderSide(color: Colors.blueAccent))),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              margin: EdgeInsets
                                                                  .only(),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      85,
                                                                      7)),
                                                              // color: const Color.fromARGB(255, 255, 255, 255),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Radio(
                                                                        activeColor:
                                                                            Colors.cyanAccent,
                                                                        value:
                                                                            "Greater",
                                                                        groupValue:
                                                                            value.Current_option,
                                                                        onChanged:
                                                                            (abc) {
                                                                          Value_greater =
                                                                              abc;
                                                                          value.Update_Curent_Option(
                                                                              abc.toString());
                                                                          print(
                                                                              value.Current_option);
                                                                        },
                                                                      ),
                                                                      Text(
                                                                        "Greater",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Radio(
                                                                        activeColor:
                                                                            Colors.cyanAccent,
                                                                        value:
                                                                            "Less",
                                                                        groupValue:
                                                                            value.Current_option,
                                                                        onChanged:
                                                                            (abc) {
                                                                          Value_greater =
                                                                              abc;
                                                                          value.Update_Curent_Option(
                                                                              abc.toString());
                                                                          print(
                                                                              value.Current_option);
                                                                        },
                                                                      ),
                                                                      Text(
                                                                        "Less",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print("object.....");
                                                      abc = true;
                                                      setState(() {});

                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      value.Update_Height(0.0);
                                                      value.Update_Icon(Icon(
                                                        Icons
                                                            .arrow_drop_down_outlined,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 0, 0, 0),
                                                        size: 50,
                                                      ));
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black,
                                                                blurRadius: 5,
                                                                offset: Offset(
                                                                    0, 0))
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 255, 85, 7)),
                                                      child: Center(
                                                          child: Text(
                                                        "Done",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 6, left: 50, right: 50),
                                height: 2,
                                width: double.infinity,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                // child: value.Pull_Icons,
                              ),
                              InkWell(
                                  onTap: () {
                                    if (value.Height_Of_Container <= 0.0) {
                                      value.Update_Height(300.0);
                                      value.Update_Icon(Icon(
                                        Icons.arrow_drop_up_outlined,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        size: 50,
                                      ));
                                    } else {
                                      value.Update_Height(0.0);
                                      value.Update_Icon(Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        size: 50,
                                      ));
                                    }
                                  },
                                  child: value.Pull_Icons)
                            ],
                          );
                        },
                      )
                    : SizedBox(),

                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("${current_user?.uid}")
                        .doc(widget.Form_name)
                        .collection("User_entries")
                        .orderBy('Index', descending: false)
                        // .where("uid", isEqualTo: current_user?.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                          "Something went wrong",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CupertinoActivityIndicator());
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Text(
                          "No data found",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        );
                      }
                      if (snapshot != null && snapshot.data != null) {
                        Sum = snapshot.data!.docs.length;
                        // for (var element in snapshot.data!.docs) {
                        //   print(
                        //       "DoC_Idssssssssssssssssssssssssssssssssssssssss${element.id}");
                        // }

                        int length_of_values = snapshot.data!.docs.length;

                        values.clear();

                        Doc_Ids.clear();

                        INDEX.clear();
                        Submit_Date.clear();
                        for (int i = 0; i < length_of_values; i++) {
                          List<String> temp = [];

                          if (delete) {
                            if (Trash.contains(snapshot.data!.docs[i].id) ==
                                false) {
                              print("Contain On Trash ********************");
                              continue;
                            }
                          } else if (Trash.contains(
                              snapshot.data!.docs[i].id)) {
                            print("Contain On Trash ********************");
                            continue;
                          }
                          // ---------------------------------------------------------------
                          // Submit_Date.add(snapshot.data!.docs[i]["Date"]);
                          // var aa = (snapshot.data!.docs[i]["Date"])
                          //     .toString()
                          //     .split("/");
                          // ---------------------------------------------------------------------------------- (filter data work)---------------------
                          if (Filter) {
                            if (Filter_Value == false) {
                              print("Date...");
                              if (Date_Range == false) {
                                if (xyz == true &&
                                    Date_Controll.text.isNotEmpty) {
                                  String y = Date_Controll.text;
                                  print(y);
                                  var temp1 = y.split("/");
                                  if (int.parse(temp1[0]) < 10 &&
                                      temp1[0] != "01" &&
                                      temp1[0] != "02" &&
                                      temp1[0] != "03" &&
                                      temp1[0] != "04" &&
                                      temp1[0] != "05" &&
                                      temp1[0] != "06" &&
                                      temp1[0] != "07" &&
                                      temp1[0] != "08" &&
                                      temp1[0] != "09") {
                                    temp1[0] = "0${temp1[0]}";
                                  }
                                  if (int.parse(temp1[1]) < 10 &&
                                      temp1[1] != "01" &&
                                      temp1[1] != "02" &&
                                      temp1[1] != "03" &&
                                      temp1[1] != "04" &&
                                      temp1[1] != "05" &&
                                      temp1[1] != "06" &&
                                      temp1[1] != "07" &&
                                      temp1[1] != "08" &&
                                      temp1[1] != "09") {
                                    temp1[1] = "0${temp1[1]}";
                                  }
                                  String x;
                                  // x = snapshot.data!.docs[i]["Date"];
                                  print("d-------------- ${Date_Fild}");
                                  if (Date_select == "Submit Date") {
                                    x = snapshot.data!.docs[i]["Date"];
                                  } else {
                                    int k = Date_Fild.indexOf(
                                        Date_select.toString());
                                    int a = Date_Fild_ind[k - 1];
                                    x = snapshot.data!.docs[i][a.toString()];
                                  }
                                  var temp2 = x.split("/");
                                  if (int.parse(temp2[0]) < 10 &&
                                      temp2[0] != "01" &&
                                      temp2[0] != "02" &&
                                      temp2[0] != "03" &&
                                      temp2[0] != "04" &&
                                      temp2[0] != "05" &&
                                      temp2[0] != "06" &&
                                      temp2[0] != "07" &&
                                      temp2[0] != "08" &&
                                      temp2[0] != "09") {
                                    temp2[0] = "0${temp2[0]}";
                                  }
                                  if (int.parse(temp2[1]) < 10 &&
                                      temp2[1] != "01" &&
                                      temp2[1] != "02" &&
                                      temp2[1] != "03" &&
                                      temp2[1] != "04" &&
                                      temp2[1] != "05" &&
                                      temp2[1] != "06" &&
                                      temp2[1] != "07" &&
                                      temp2[1] != "08" &&
                                      temp2[1] != "09") {
                                    temp2[1] = "0${temp2[1]}";
                                  }
                                  print(temp1.length);
                                  // -----------------------------------------------------------------------  ( Convart Date Formate )
                                  DateTime date1_Temp1 = DateTime.parse(
                                      "${temp1[2]}-${temp1[1]}-${temp1[0]}");
                                  print(date1_Temp1.day);
                                  DateTime date2_Temp2 = DateTime.parse(
                                      "${temp2[2]}-${temp2[1]}-${temp2[0]}");
                                  if (Date_Greater == "Greater") {
                                    if (date1_Temp1.isBefore(date2_Temp2)
                                        // ||
                                        //     date1_Temp1
                                        //         .isAtSameMomentAs(date2_Temp2)
                                        ) {
                                      print("big.............");
                                    } else {
                                      continue;
                                    }
                                  } else if (Date_Greater == "Less") {
                                    if (date2_Temp2.isBefore(date1_Temp1)
                                        //  ||
                                        //     date2_Temp2
                                        //         .isAtSameMomentAs(date1_Temp1)
                                        ) {
                                      print("big.............");
                                    } else {
                                      continue;
                                    }
                                  } //---------------------------------------------------------------------------------  ( Date Range filter )
                                }
                              } else if (Date_Range == true) {
                                print("Range true......");
                                if (xyz == true &&
                                    Start_Date_Controll.text.isNotEmpty &&
                                    End_Date_Controll.text.isNotEmpty) {
                                  String start_Date = Start_Date_Controll.text;
                                  var split_S_D = start_Date.split("/");

                                  if (int.parse(split_S_D[0]) < 10) {
                                    split_S_D[0] = "0${split_S_D[0]}";
                                  }
                                  if (int.parse(split_S_D[1]) < 10) {
                                    split_S_D[1] = "0${split_S_D[1]}";
                                  }

                                  String end_date = End_Date_Controll.text;
                                  var split_E_D = end_date.split("/");
                                  if (int.parse(split_E_D[0]) < 10) {
                                    split_E_D[0] = "0${split_E_D[0]}";
                                  }
                                  print(
                                      "AAAAA=====${(int.parse(split_E_D[1])) < 10}");
                                  if ((int.parse(split_E_D[1])) < 10) {
                                    print("Month=${split_E_D[1]}");
                                    split_E_D[1] = "0${split_E_D[1]}";
                                  }

                                  //  ---------------------------------------------------------------- ( Database Date work)
                                  String x;
                                  // x = snapshot.data!.docs[i]["Date"];
                                  print("d-------------- ${Date_Fild}");
                                  if (Date_select == "Submit Date") {
                                    x = snapshot.data!.docs[i]["Date"];
                                  } else {
                                    int k = Date_Fild.indexOf(
                                        Date_select.toString());
                                    int a = Date_Fild_ind[k - 1];
                                    x = snapshot.data!.docs[i][a.toString()];
                                  }
                                  var temp2 = x.split("/");
                                  if (int.parse(temp2[0]) < 10) {
                                    temp2[0] = "0${temp2[0]}";
                                  }
                                  if (int.parse(temp2[1]) < 10) {
                                    temp2[1] = "0${temp2[1]}";
                                  }
                                  print(split_S_D.length);
                                  // -----------------------------------------------------------------------  ( Convart Date Formate )
                                  DateTime start_date_format = DateTime.parse(
                                      "${split_S_D[2]}-${split_S_D[1]}-${split_S_D[0]}");
                                  DateTime end_date_format = DateTime.parse(
                                      "${split_E_D[2]}-${split_E_D[1]}-${split_E_D[0]}");

                                  DateTime Date_Of_Database = DateTime.parse(
                                      "${temp2[2]}-${temp2[1]}-${temp2[0]}");

                                  if (Date_Of_Database.isAfter(
                                          start_date_format) &&
                                      Date_Of_Database.isBefore(
                                          end_date_format)) {
                                    print("Mid");
                                  } else {
                                    continue;
                                  }
                                }
                              }
                            } else if (Filter_Value == true) {
                              print("Stap 1");
                              if (Value_Range == false) {
                                print("Stap 2");
                                if (abc == true &&
                                    Value_Controll.text.isNotEmpty) {
                                  print("Stap 3");
                                  int User_value =
                                      int.parse(Value_Controll.text);
                                  int k = Value_Fild.indexOf(
                                      Value_select.toString());
                                  // int a = Value_Fild_ind[k];
                                  print("Convert int... $a");
                                  int selected_column = Value_Fild_ind[k];
                                  if (snapshot.data!.docs[i]
                                          [selected_column.toString()] !=
                                      "null") {
                                    int data_base_value = int.parse(snapshot
                                        .data!
                                        .docs[i][selected_column.toString()]);
                                    if (Value_greater == "Greater") {
                                      print("Stap 4");
                                      if (User_value < data_base_value &&
                                          data_base_value != "null") {
                                        print("Stap 5");
                                        print("Value Big..");
                                      } else {
                                        continue;
                                      }
                                    } else if (Value_greater == "Less") {
                                      if (User_value > data_base_value &&
                                          data_base_value != "null") {
                                        print("Value small..");
                                      } else {
                                        continue;
                                      }
                                    }
                                  } else {
                                    break;
                                  }
                                }
                              } else if (Value_Range == true) {
                                int value1 =
                                    int.parse(Start_Value_Controll.text);
                                int value2 = int.parse(End_Value_Controll.text);
                                int k =
                                    Value_Fild.indexOf(Value_select.toString());

                                int selected_column = Value_Fild_ind[k];
                                int data_base_value = int.parse(snapshot
                                    .data!.docs[i][selected_column.toString()]);
                                if (value1 < data_base_value &&
                                    value2 > data_base_value &&
                                    data_base_value != "null") {
                                } else {
                                  continue;
                                }
                              }
                            }
                          }
                          Doc_Ids.add(snapshot.data!.docs[i].id);
                          print("L----------- ${Doc_Ids.length}");
                          for (int j = 0; j < length_of_lable; j++) {
                            print("J......$length_of_entries");
                            if (int.parse(snapshot.data!.docs[i]["Length"]) -
                                    1 <
                                j) {
                              temp.add("null");
                            } else {
                              temp.add(snapshot.data!.docs[i][j.toString()]);
                            }
                          }
                          //================================================= (add document id)
                          temp.add(snapshot.data!.docs[i].id);
                          values.add(temp);
                          INDEX.add(i);
                        }

                        if (value.Sort_By_Selection == "Latest") {
                          values = values.reversed.toList();
                        }

                        print("Values ****** ${values}");
                        my_columns.clear();
                        // my_row.clear();
                        provider_object.My_Row.clear();
                        try {
                          for (int i = 0; i < length_of_lable; i++) {
                            print(Lables[i]);

                            my_columns.add(DataColumn(
                                label: Expanded(
                              child: Center(
                                child: Text(
                                  Lables[i],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            )));
                          }
                        } catch (r) {
                          print("Error............");
                        }

                        my_columns.insert(
                            0,
                            DataColumn(
                                label: Center(
                              child: delete
                                  ? Icon(
                                      Icons.delete,
                                      size: 30,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      shadows: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            blurRadius: 20,
                                            offset: Offset(0, 0))
                                      ],
                                    )
                                  : Text(
                                      "S.no",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                            )));
                        // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        int My_lenght =
                            a ? values!.length : search_values.length;

                        for (int i = 0; i < My_lenght; i++) {
                          List<DataCell> temp = [];
                          // String Doc_Id = snapshot.data!.docs[i].id;

                          for (int j = 0; j < length_of_lable; j++) {
                            temp.add(DataCell(
                              // onLongPress: () {
                              //   delete = true;
                              //   setState(() {});
                              // },
                              onTap: () {
                                // print("Data row= ${my_row}");

                                if (delete == false) {
                                  // Navigator.pop(context);
                                  print(values[i][values[i].length - 1]);
                                  Get.to(() => full_Data(
                                        lebals: Lables,
                                        User_Data:
                                            a ? values[i] : search_values[i],
                                        Doc_Id: values[i][values[i].length - 1],
                                        Form_Name: widget.Form_name,
                                        Trash: Trash,
                                        Dos_Ids: Doc_Ids,
                                        sum: snapshot.data!.docs[i]["Index"],
                                        date: snapshot.data!.docs[i]["Date"],
                                        time: snapshot.data!.docs[i]["Time"],
                                        refresh: refresh,
                                      ));
                                }
                              },
                              Center(
                                child: Text(
                                  a ? values[i][j] : search_values[i][j],
                                  style: TextStyle(
                                      color: Color.fromARGB(173, 0, 0, 0)),
                                ),
                              ),
                            ));
                          }

                          temp.insert(
                              0,
                              DataCell(Center(
                                child: delete
                                    ? InkWell(
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 1, 11, 27),
                                                    title: Text(
                                                      "Delete '${values[i][0]}' That Row ? ",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    content: Text(
                                                      "Delete '${values[i][0]}' That Row from this device ",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Trash.remove(
                                                                Doc_Ids[i]);
                                                            Doc_Ids.remove(
                                                                Doc_Ids[i]);
                                                            Map<String, String>
                                                                map_Trash = {};

                                                            for (int i = 0;
                                                                i <
                                                                    Trash
                                                                        .length;
                                                                i++) {
                                                              map_Trash[i
                                                                      .toString()] =
                                                                  Trash[i];
                                                            }
                                                            map_Trash[
                                                                    "Length"] =
                                                                Trash.length
                                                                    .toString();
                                                            map_Trash[
                                                                    "userId"] =
                                                                current_user!
                                                                    .uid
                                                                    .toString();
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    current_user!
                                                                        .uid)
                                                                .doc(widget
                                                                    .Form_name)
                                                                .collection(
                                                                    "Trash")
                                                                .doc("Trash")
                                                                .set(map_Trash);
                                                            setState(() {});

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text("Restore")),
                                                      TextButton(
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "${current_user?.uid}")
                                                                .doc(widget
                                                                    .Form_name)
                                                                .collection(
                                                                    "User_entries")
                                                                .doc(Doc_Ids[i])
                                                                .delete();

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                              "parma Delete")),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color:
                                                Color.fromARGB(255, 255, 0, 0),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        (i + 1).toString(),
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(173, 0, 0, 0)),
                                      ),
                              )));
                          provider_object.Add_Row(temp);
                          // Filter = false;
                          xyz = false;
                          abc = false;
                        }

                        return Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 155, 155, 155)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Short By',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: Short_By.map((item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )).toList(),
                                        value: value.Sort_By_Selection,
                                        onChanged: (val) {
                                          print("object");

                                          // Short_By_Select = val;
                                          value.Update_Sort_By(val);
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(bottom: 80, top: 5),
                                      child: DataTable(
                                        border: TableBorder(
                                          horizontalInside: BorderSide(
                                              color:
                                                  Color.fromARGB(167, 8, 8, 8)),
                                          // verticalInside: BorderSide(
                                          //     color: const Color.fromARGB(
                                          //         167, 255, 255, 255)),
                                          // verticalInside: BorderSide(color: Colors.white),
                                        ),
                                        columns: my_columns,
                                        rows: value.My_Row,
                                        headingRowColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) =>
                                                    const Color.fromARGB(
                                                        172, 0, 0, 0)),
                                        // rows: provider_object.My_Row,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return SizedBox();
                    }),
              ],
            )),
      );
    }));
  }
}
