import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './Data_show.dart';

class Trash_page extends StatefulWidget {
  // List<String>? All_Names_Of_Forms = [];
  // Trash_page({required this.Trash, this.All_Names_Of_Forms});

  @override
  State<Trash_page> createState() => _Trash_pageState();
}

class _Trash_pageState extends State<Trash_page> {
  List<String> Trash = [];
  List<String> All_Names_Of_Forms = [];
  bool abc = false;
  var Form_name;
  int length_of_Form_name = 2;
  int doc_index = 1;

  User? current_user = FirebaseAuth.instance.currentUser;
  Widget Delet_form(String form_name, List trash) {
    return Column(
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(current_user!.uid)
              .doc(form_name)
              .collection("User_entries")
              .where("uid", isEqualTo: current_user?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                "Something went wrong",
                style: TextStyle(color: Colors.white),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No data found",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            if (snapshot != null && snapshot.data != null) {
              int length_Doc = snapshot.data!.docs.length;

              for (int i = 0; i < length_Doc; i++) {
                var Do_Id = snapshot.data!.docs[i].id;
                FirebaseFirestore.instance
                    .collection(current_user!.uid)
                    .doc(form_name)
                    .collection("User_entries")
                    .doc(Do_Id)
                    .delete();
              }
              print("Trash Delete :- Doc_Id ");
              FirebaseFirestore.instance
                  .collection(current_user!.uid)
                  .doc(form_name)
                  .collection("Trash")
                  .doc("Trash")
                  .delete();

              return SizedBox();
            }
            return SizedBox();
          },
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(current_user!.uid)
              .doc(form_name)
              .collection("form_list")
              .where("UserId", isEqualTo: current_user?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                "Something went wrong",
                style: TextStyle(color: Colors.white),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No data found",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            if (snapshot != null && snapshot.data != null) {
              int length_Doc = snapshot.data!.docs.length;

              for (int i = 0; i < length_Doc; i++) {
                var Do_Id = snapshot.data!.docs[i].id;
                FirebaseFirestore.instance
                    .collection(current_user!.uid)
                    .doc(form_name)
                    .collection("form_list")
                    .doc(Do_Id)
                    .delete();
              }
              abc = false;
              // setState(() {});
              return SizedBox();
            }
            return SizedBox();
          },
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(current_user!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                "Something went wrong",
                style: TextStyle(color: Colors.white),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No data found",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            if (snapshot != null && snapshot.data != null) {
              trash.remove(form_name);
              int length_Trash = trash.length;
              Map<String, String> map_Trash = {};

              for (int i = 0; i < length_Trash; i++) {
                map_Trash[i.toString()] = trash[i];
              }
              map_Trash["Length"] = trash.length.toString();
              map_Trash["userId"] = current_user!.uid.toString();
              FirebaseFirestore.instance
                  .collection("${current_user?.uid}")
                  .doc("Trash")
                  .set(map_Trash);
              return SizedBox();
            }
            return SizedBox();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("${current_user?.uid}")
          .where("userId", isEqualTo: current_user?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            "Something went wrong",
            style: TextStyle(color: Colors.white),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CupertinoActivityIndicator());
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No data found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        if (snapshot != null && snapshot.data != null) {
          Trash.clear();
          int length_of_Trash = int.parse(snapshot.data!.docs[0]["Length"]);

          print("Length___ = ${snapshot.data!.docs.length}");

          if (snapshot.data!.docs.length == 2) {
            length_of_Form_name = int.parse(snapshot.data!.docs[1]["Length"]);
            doc_index = 1;

            for (int i = 0; i < length_of_Trash; i++) {
              Trash.add(snapshot.data!.docs[0][i.toString()]);
            }
          } else {
            length_of_Form_name = int.parse(snapshot.data!.docs[0]["Length"]);
            doc_index = 0;
          }
          print("doc_index = $doc_index");

          All_Names_Of_Forms.clear();
          for (var i = 0;
              i < int.parse(snapshot.data!.docs[doc_index]["Length"]);
              i++) {
            All_Names_Of_Forms.add(
                snapshot.data!.docs[doc_index][i.toString()]);
          }

          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: Trash.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, mainAxisExtent: 150),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            Data_show(
                              Form_name: Trash[index],
                            ),
                            transition: Transition.topLevel,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubic,
                            // popGesture: true,
                            fullscreenDialog: true,
                          );
                        },
                        child: Container(
                          // height: 1000,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(148, 255, 145, 0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 110,
                                width: 90,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.all(5),
                                        child: InkWell(
                                          onTap: () {
                                            Form_name = Trash[index];
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 1, 11, 27),
                                                    title: Text(
                                                      "Delete ${Trash[index]} ? ",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    content: Text(
                                                      "Delete ${Trash[index]} from this device ",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            All_Names_Of_Forms
                                                                .add(Trash[
                                                                    index]);
                                                            print(
                                                                "ssssssssssssssssss ${All_Names_Of_Forms}");
                                                            Trash.removeAt(
                                                                index);
                                                            Map<String, String>
                                                                Map_Form_Name =
                                                                {};
                                                            for (int i = 0;
                                                                i <
                                                                    All_Names_Of_Forms
                                                                        .length;
                                                                i++) {
                                                              Map_Form_Name[i
                                                                      .toString()] =
                                                                  All_Names_Of_Forms[
                                                                      i];
                                                            }
                                                            Map_Form_Name[
                                                                    "userId"] =
                                                                current_user!
                                                                    .uid
                                                                    .toString();

                                                            Map_Form_Name[
                                                                    "Length"] =
                                                                All_Names_Of_Forms
                                                                    .length
                                                                    .toString();
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "${current_user?.uid}")
                                                                .doc("names")
                                                                .set(
                                                                    Map_Form_Name);
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
                                                                    "userId"] =
                                                                current_user!
                                                                    .uid
                                                                    .toString();

                                                            map_Trash[
                                                                    "Length"] =
                                                                Trash.length
                                                                    .toString();
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "${current_user?.uid}")
                                                                .doc("Trash")
                                                                .set(map_Trash);

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text("Restore")),
                                                      TextButton(
                                                          onPressed: () {
                                                            abc = true;
                                                            setState(() {});

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                              "parma Delete")),
                                                    ],
                                                  );
                                                });

                                            // // setState(() {});
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            shadows: [
                                              BoxShadow(
                                                  blurRadius: 3,
                                                  color: Colors.black)
                                            ],
                                          ),
                                        )),
                                    Container(
                                      // color: Colors.black,
                                      padding: EdgeInsets.only(bottom: 50),
                                      child: Center(
                                        child: Text(
                                          Trash[index],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 2, 2, 2),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(162, 226, 172, 138),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                      bottom: Radius.circular(60),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 5,
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                abc ? Delet_form(Form_name, Trash) : SizedBox(),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
