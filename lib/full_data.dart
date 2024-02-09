import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:list_nest2/Data_show.dart';
import 'package:list_nest2/show_form.dart';

class full_Data extends StatelessWidget {
  List? lebals = <String>[];
  List? Dos_Ids = <String>[];
  List? User_Data = <String>[];
  String? Doc_Id;
  String? Form_Name;
  List<String>? Trash = [];
  int sum;
  String date;
  String time;
  Function refresh;

  full_Data(
      {this.lebals,
      this.User_Data,
      this.Doc_Id,
      this.Form_Name,
      this.Trash,
      this.Dos_Ids,
      required this.sum,
      required this.date,
      required this.time,
      required this.refresh});
  Color text_fill_color = Color.fromARGB(255, 255, 255, 255);
  Color t_color = Color.fromARGB(255, 255, 239, 230);
  Color orange_color = Color.fromARGB(255, 250, 79, 0);
  Color text_hint_color = Color.fromARGB(104, 0, 0, 0);
  Color text__enab_border_color = Color.fromARGB(255, 0, 0, 0);
  Color text__focus_border_color = Color.fromARGB(255, 4, 142, 255);
  Color text_label_color = Color.fromARGB(255, 83, 83, 83);
  Color body_color = Color.fromARGB(255, 255, 255, 255);

  @override
  Widget build(BuildContext context) {
    User? current_user = FirebaseAuth.instance.currentUser;
    print("IDDDD=$Doc_Id");
    return Container(
      // padding: EdgeInsets.only(top: 150),
      width: double.infinity,
      height: double.infinity,
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
      child: WillPopScope(
        onWillPop: () {
          // Get.off(Data_show(
          //   Form_name: Form_Name,
          // ));
          Navigator.pop(context);
          return Future.value(false);
        },
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(Form_Name!),
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text("Delete"),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor:
                                      Color.fromARGB(255, 1, 11, 27),
                                  title: Text(
                                    "Delete ? ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                    "Delete that Row from this form & device ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Cancel")),
                                    TextButton(
                                        onPressed: () {
                                          Trash!.add(Doc_Id!);
                                          Dos_Ids!.remove(Doc_Id);
                                          Map<String, String> map_Trash = {};

                                          for (int i = 0;
                                              i < Trash!.length;
                                              i++) {
                                            map_Trash[i.toString()] = Trash![i];
                                          }
                                          map_Trash["Length"] =
                                              Trash!.length.toString();
                                          map_Trash["userId"] =
                                              current_user!.uid.toString();
                                          FirebaseFirestore.instance
                                              .collection(current_user!.uid)
                                              .doc(Form_Name)
                                              .collection("Trash")
                                              .doc("Trash")
                                              .set(map_Trash);
                                          Navigator.pop(context);
                                          // Get.off(Data_show(
                                          //   Form_name: Form_Name,
                                          // ));
                                          refresh();
                                          Navigator.pop(context);

                                          // Navigator.of(context).pop(true);
                                        },
                                        child: Text("Delete")),
                                  ],
                                );
                              });
                        },
                      ),
                      PopupMenuItem(
                        child: Text("Edit"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Show_my_form(
                                  Form_Name: Form_Name,
                                  Doc_Id: Doc_Id,
                                  update: true,
                                  User_Data: User_Data,
                                  Sum: sum,
                                ),
                              ));
                          // Get.off(
                          //   Show_my_form(
                          //     Form_Name: Form_Name,
                          //     Doc_Id: Doc_Id,
                          //     update: true,
                          //     User_Data: User_Data,
                          //     Sum: sum,
                          //   ),
                          // );
                        },
                      ),
                      PopupMenuItem(
                        child: Text("Info"),
                        onTap: () {
                          Get.defaultDialog(
                              title: Form_Name.toString(),
                              middleText: "Date : ${date}",
                              actions: [Text("Time:${time}")]);
                        },
                      ),
                    ];
                  },
                ),
                // IconButton(
                //     onPressed: () {
                //       print(
                //           "Doc_Id---------------------------------- ${Doc_Id}");
                //       showDialog(
                //           context: context,
                //           builder: (context) {
                //             return AlertDialog(
                //               backgroundColor: Color.fromARGB(255, 1, 11, 27),
                //               title: Text(
                //                 "Delete ? ",
                //                 style: TextStyle(color: Colors.white),
                //               ),
                //               content: Text(
                //                 "Delete that Row from this form & device ",
                //                 style: TextStyle(color: Colors.white),
                //               ),
                //               actions: [
                //                 TextButton(
                //                     onPressed: () => Navigator.pop(context),
                //                     child: Text("Cancel")),
                //                 TextButton(
                //                     onPressed: () {
                //                       Trash!.add(Doc_Id!);
                //                       Dos_Ids!.remove(Doc_Id);
                //                       Map<String, String> map_Trash = {};

                //                       for (int i = 0; i < Trash!.length; i++) {
                //                         map_Trash[i.toString()] = Trash![i];
                //                       }
                //                       map_Trash["Length"] =
                //                           Trash!.length.toString();
                //                       map_Trash["userId"] =
                //                           current_user!.uid.toString();
                //                       FirebaseFirestore.instance
                //                           .collection(current_user!.uid)
                //                           .doc(Form_Name)
                //                           .collection("Trash")
                //                           .doc("Trash")
                //                           .set(map_Trash);
                //                       Navigator.pop(context);
                //                       Get.off(Data_show(
                //                         Form_name: Form_Name,
                //                       ));
                //                       // Navigator.pop(context);

                //                       // Navigator.of(context).pop(true);
                //                     },
                //                     child: Text("Delete")),
                //               ],
                //             );
                //           });
                //     },
                //     icon: Icon(Icons.delete)),
                // IconButton(
                // onPressed: () {
                //   Get.off(
                //     Show_my_form(
                //       Form_Name: Form_Name,
                //       Doc_Id: Doc_Id,
                //       update: true,
                //       User_Data: User_Data,
                //     ),
                //   );
                // },
                // icon: Icon(Icons.edit))
              ],
              // forceMaterialTransparency: true,
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: orange_color,
            ),
            body: ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemCount: (User_Data?.length)! - 1,
              itemBuilder: (context, index) {
                return Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 226, 171, 138),
                        borderRadius: BorderRadiusDirectional.horizontal(
                          end: Radius.circular(5),
                          start: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        lebals![index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 102, 255)),
                      )),
                      height: 45,
                      width: 150,
                      // color: Colors.white,
                    ),
                    Container(
                      height: 60,
                      width: 150,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(157, 226, 172, 138),
                          borderRadius: BorderRadiusDirectional.horizontal(
                              end: Radius.circular(20),
                              start: Radius.circular(5))),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(3),
                          // margin: EdgeInsets.all(2),

                          child: Center(
                              child: Text(
                            User_Data![index],
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w500),
                          )),
                          // color: Colors.white,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 122, 92, 73),
                              borderRadius: BorderRadiusDirectional.horizontal(
                                  end: Radius.circular(20),
                                  start: Radius.circular(5))),
                          height: 50,
                          width: 150,
                        ),
                      ),
                    ),
                  ],
                ));
              },
            )),
      ),
    );
  }
}
