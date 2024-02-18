import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class view_Templets extends StatefulWidget {
  List<Widget> Templates_filds;
  String? temp_name;
  List<String> Labels;
  List<String> hints;
  List<String> fields_name;
  view_Templets(
      {required this.Templates_filds,
      required this.temp_name,
      required this.fields_name,
      required this.Labels,
      required this.hints});

  @override
  State<view_Templets> createState() => _view_TempletsState();
}

class _view_TempletsState extends State<view_Templets> {
  // Color body_color = Color.fromARGB(255, 255, 239, 230);
  Color text_fill_color = Color.fromARGB(255, 255, 255, 255);

  Color t_color = Color.fromARGB(255, 255, 255, 255);

  Color orange_color = Color.fromARGB(255, 250, 79, 0);

  Color text_hint_color = Color.fromARGB(104, 0, 0, 0);

  Color text__enab_border_color = Color.fromARGB(255, 0, 0, 0);

  Color text__focus_border_color = Color.fromARGB(255, 250, 79, 0);

  Color text_label_color = Color.fromARGB(255, 250, 79, 0);

  Color body_color = Color.fromARGB(255, 255, 239, 230);

  var Form_name_Controler = TextEditingController();

  User? current_user = FirebaseAuth.instance.currentUser;

  List<String> All_forms_name = [];

  int length_of_Form_name = 0;

  int doc_index = 2;
  bool loder = false;
  void data_sand() async {
    Map<String, String> Map_Filds_Name =
        {}; //firebase me store karne ke liye map me convert kiya
    Map<String, String> Map_Leble_Text =
        {}; //firebase me store karne ke liye map me convert kiya
    Map<String, String> Map_Hint_Text =
        {}; //firebase me store karne ke liye map me convert kiya
    for (int i = 0; i < widget.fields_name!.length; i++) {
      print("Filds name ==== ${widget.fields_name[i]}");
      Map_Filds_Name[i.toString()] = widget.fields_name![i];
    }
    Map_Filds_Name["UserId"] = "${current_user?.uid}";
    Map_Filds_Name["Length"] = "${widget.fields_name!.length}";
    Map_Filds_Name["Grid"] = "2";
    print("Filds name MAp ==== ${Map_Filds_Name}");
    await FirebaseFirestore.instance
        .collection("${current_user?.uid}")
        .doc(Form_name_Controler.text)
        .collection("form_list")
        .doc("filds name")
        .set(Map_Filds_Name);
    print("Data sand Done.....................");

    for (int i = 0; i < widget.Labels.length; i++) {
      Map_Leble_Text[i.toString()] = widget.Labels[i];
    }
    Map_Leble_Text["UserId"] = "${current_user?.uid}";
    Map_Leble_Text["Length"] = "${widget.Labels.length}";

    await FirebaseFirestore.instance
        .collection("${current_user?.uid}")
        .doc(Form_name_Controler.text)
        .collection("form_list")
        .doc("Lables Text")
        .set(Map_Leble_Text);
    for (int i = 0; i < widget.hints.length; i++) {
      Map_Hint_Text[i.toString()] = widget.hints[i];
    }
    Map_Hint_Text["UserId"] = "${current_user?.uid}";
    Map_Hint_Text["Length"] = "${widget.hints.length.toString()}";
    print("Lables name MAp ==== ${Map_Hint_Text}");
    await FirebaseFirestore.instance
        .collection("${current_user?.uid}")
        .doc(Form_name_Controler.text)
        .collection("form_list")
        .doc("hint Text")
        .set(Map_Hint_Text);
    print(Map_Filds_Name);
    // widget.Filds_Name!.clear();
    // Hint_Text.clear();
    // Leble_Text.clear();
    All_forms_name!.insert(0, Form_name_Controler.text);
    Map<String, String> Map_Form_Names = {};
    for (int i = 0; i < All_forms_name!.length; i++) {
      Map_Form_Names[i.toString()] = All_forms_name![i];
    }
    Map_Form_Names["userId"] = current_user!.uid.toString();
    Map_Form_Names["Length"] = All_forms_name!.length.toString();
    print("Done1...........");

    await FirebaseFirestore.instance
        .collection("${current_user!.uid}")
        .doc("names")
        .set(Map_Form_Names);
    print("Done........... $Map_Form_Names");

    Form_name_Controler.clear();

    loder = false;
    // setState(() {
    // });

    // Navigator.pop(context);
    Navigator.pop(context);
    // Navigator.pop(context);
    Get.snackbar("Notification", "Templet Created...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: orange_color,
          title: Text("${widget.temp_name}"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: body_color,
        floatingActionButton: loder
            ? SizedBox()
            : Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                ),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    // ______________________________________________________________________________   ( Dialog Box )    ____________________________________________________________________________________
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          elevation: 502,
                          backgroundColor: Color.fromARGB(255, 252, 253, 255),
                          title: Text(
                            "Name of Form",
                            // Form_name,
                            style: TextStyle(color: orange_color),
                          ),
                          content: Container(
                            // padding: EdgeInsets.only(bottom: 10),
                            width: 350,
                            height: 25,
                            child: TextFormField(
                              // style: TextStyle(height: 0.3),
                              controller: Form_name_Controler,

                              minLines: 1,
                              maxLines: 1,
                              autofocus: true,
                              autocorrect: true,
                              cursorColor: const Color.fromARGB(255, 0, 0, 0),
                              decoration: InputDecoration(
                                prefixText: " ",
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: text_fill_color,
                                // disabledBorder: OutlineInputBorder(
                                //   borderSide: BorderSide(
                                //     color: Colors.white,
                                //   ),
                                // ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: text__enab_border_color,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: text__focus_border_color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  if (All_forms_name.contains(
                                          Form_name_Controler.text) ||
                                      Form_name_Controler.text == "") {
                                    Get.snackbar(
                                        "Error", "This name is already used");
                                  } else {
                                    setState(() {
                                      loder = true;
                                    });
                                    Navigator.pop(context);
                                    // Navigator.pop(context);
                                    // setState(() {});
                                    // Map<String, String> Map_Filds_Name =
                                    //     {}; //firebase me store karne ke liye map me convert kiya
                                    // Map<String, String> Map_Leble_Text =
                                    //     {}; //firebase me store karne ke liye map me convert kiya
                                    // Map<String, String> Map_Hint_Text =
                                    //     {}; //firebase me store karne ke liye map me convert kiya
                                    // for (int i = 0;
                                    //     i < widget.fields_name!.length;
                                    //     i++) {
                                    //   print(
                                    //       "Filds name ==== ${widget.fields_name[i]}");
                                    //   Map_Filds_Name[i.toString()] =
                                    //       widget.fields_name![i];
                                    // }
                                    // Map_Filds_Name["UserId"] = "${current_user?.uid}";
                                    // Map_Filds_Name["Length"] =
                                    //     "${widget.fields_name!.length}";
                                    // Map_Filds_Name["Grid"] = "2";
                                    // print("Filds name MAp ==== ${Map_Filds_Name}");
                                    // await FirebaseFirestore.instance
                                    //     .collection("${current_user?.uid}")
                                    //     .doc(Form_name_Controler.text)
                                    //     .collection("form_list")
                                    //     .doc("filds name")
                                    //     .set(Map_Filds_Name);
                                    // print("Data sand Done.....................");

                                    // for (int i = 0; i < widget.Labels.length; i++) {
                                    //   Map_Leble_Text[i.toString()] = widget.Labels[i];
                                    // }
                                    // Map_Leble_Text["UserId"] = "${current_user?.uid}";
                                    // Map_Leble_Text["Length"] =
                                    //     "${widget.Labels.length}";

                                    // await FirebaseFirestore.instance
                                    //     .collection("${current_user?.uid}")
                                    //     .doc(Form_name_Controler.text)
                                    //     .collection("form_list")
                                    //     .doc("Lables Text")
                                    //     .set(Map_Leble_Text);
                                    // for (int i = 0; i < widget.hints.length; i++) {
                                    //   Map_Hint_Text[i.toString()] = widget.hints[i];
                                    // }
                                    // Map_Hint_Text["UserId"] = "${current_user?.uid}";
                                    // Map_Hint_Text["Length"] =
                                    //     "${widget.hints.length.toString()}";
                                    // print("Lables name MAp ==== ${Map_Hint_Text}");
                                    // await FirebaseFirestore.instance
                                    //     .collection("${current_user?.uid}")
                                    //     .doc(Form_name_Controler.text)
                                    //     .collection("form_list")
                                    //     .doc("hint Text")
                                    //     .set(Map_Hint_Text);
                                    // print(Map_Filds_Name);
                                    // // widget.Filds_Name!.clear();
                                    // // Hint_Text.clear();
                                    // // Leble_Text.clear();
                                    // All_forms_name!
                                    //     .insert(0, Form_name_Controler.text);
                                    // Map<String, String> Map_Form_Names = {};
                                    // for (int i = 0; i < All_forms_name!.length; i++) {
                                    //   Map_Form_Names[i.toString()] =
                                    //       All_forms_name![i];
                                    // }
                                    // Map_Form_Names["userId"] =
                                    //     current_user!.uid.toString();
                                    // Map_Form_Names["Length"] =
                                    //     All_forms_name!.length.toString();

                                    // await FirebaseFirestore.instance
                                    //     .collection("${current_user!.uid}")
                                    //     .doc("names")
                                    //     .set(Map_Form_Names);
                                    // print("Done...........");
                                    // loder = false;

                                    // // Navigator.pop(context);
                                    // Navigator.pop(context);
                                    // Get.snackbar(
                                    //     "Notification", "Templet Created...");
                                  }
                                },
                                child: Text(
                                  "Next",
                                  style: TextStyle(color: orange_color),
                                )),
                          ],
                        );
                      },
                    );
                    // Get.off(New_Form());
                  },
                  label: Text(
                    "Use Form",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 3, 70, 90),
                    size: 30,
                  ),
                  backgroundColor: orange_color,
                ),
              ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5, left: 5, top: 10),
                    child: GridView.builder(
                      itemCount: widget.Templates_filds.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 70,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          // padding: EdgeInsets.all(5),
                          // color: Colors.white,
                          height: 20,
                          margin: EdgeInsets.all(10),
                          child: widget.Templates_filds[index],
                        );
                      },
                    ),
                  ),
                  loder
                      ? SpinKitDualRing(
                          color: const Color.fromARGB(255, 2, 2, 2),
                          size: 50.0,
                        )
                      : SizedBox()
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("${current_user?.uid}")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CupertinoActivityIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Text("");
                }
                if (snapshot != null && snapshot.data != null) {
                  print("Length___ = ${snapshot.data!.docs.length}");

                  if (snapshot.data!.docs.length == 2) {
                    length_of_Form_name =
                        int.parse(snapshot.data!.docs[1]["Length"]);
                    doc_index = 1;
                  } else {
                    length_of_Form_name =
                        int.parse(snapshot.data!.docs[0]["Length"]);
                    doc_index = 0;
                  }
                  print("doc_index = $doc_index");

                  int length =
                      int.parse(snapshot.data!.docs[doc_index]["Length"]);
                  print("Length___ = ${length}");
                  All_forms_name.clear();
                  for (var i = 0; i < length; i++) {
                    All_forms_name.add(
                        snapshot.data!.docs[doc_index][i.toString()]);
                  }
                  if (loder) {
                    data_sand();
                    print("Load88888888");
                  }

                  return SizedBox();
                }
                return Container();
              },
            )
          ],
        ));
  }
}
