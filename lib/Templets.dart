// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:list_nest2/Data_show.dart';
import 'package:list_nest2/Login.dart';
import 'package:list_nest2/aboutUs.dart';
import 'package:list_nest2/show_form.dart';
import 'package:list_nest2/view_templets.dart';
import './New_Form.dart';
import './my_providers.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import './Trash.dart';

class Templets_page extends StatefulWidget {
  Templets_page({
    super.key,
  });

  @override
  State<Templets_page> createState() => _Templets_pageState();
}

class _Templets_pageState extends State<Templets_page> {
  var Form_name_Controler = TextEditingController();

  // List<String> Form_names = []; // All Forms Name
  // List<Color> SCC = []; // selected container color

  bool Dcolor = false; //Divider color
  bool error = false;
  bool run = true;
  bool s1 = false;
  bool s2 = false;
  bool error1 = false;
  bool abc = false;
  var Name;
  String? account_name;
  String? account_email;
  String? account_Id;
  int length_of_Form_name = 0;
  int doc_index = 0;

  final User? current_user = FirebaseAuth.instance.currentUser;

  var search_control = TextEditingController();
  List search_results = <String>[];
  List<String> Trash = [];
  bool a = true;

  @override
  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.dismiss();
  }

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

  void search_filter(String element) {
    final provider_object = Provider.of<my_providers>(context, listen: false);
    if (element.isEmpty) {
      search_results.clear();
      for (int i = 0; i < provider_object.Forms_name.length; i++) {
        search_results.add(provider_object.Forms_name[i]);
      }
      // search_results = Form_names;
    } else {
      search_results.clear();
      for (int i = 0; i < provider_object.Forms_name.length; i++) {
        print("I=" + i.toString());
        if (provider_object.Forms_name[i]
            .toLowerCase()
            .startsWith(element.toLowerCase())) {
          search_results.add(provider_object.Forms_name[i]);
        }
      }
    }

    print("search r $search_results");
  }

// =======================================================================  ( function )  ===============================
  Widget design_fileds({
    required String Hint_Text,
    required String Leble_Text,
    required String field,
  }) {
    if (field == "Text") {
      return TextFormField(
        // autofocus: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5),
          hintText: Hint_Text,
          labelText: Leble_Text,
          filled: true,
          hintStyle: TextStyle(color: text_hint_color),
          labelStyle: TextStyle(
            color: text_label_color,
          ),
          fillColor: text_fill_color,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: text__focus_border_color),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: text__enab_border_color),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else if (field == "Date") {
      DateTime? Date = DateTime.now();
      return InkWell(
        onTap: () async {
          DateTime? Selected_Date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2026));
          if (Selected_Date != null) {
            print("object...");

            Date = Selected_Date;
          }
          print("Date:-  ${Date!.day}/${Date!.month}/${Date!.year}");
        },
        child: AbsorbPointer(
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            controller: (TextEditingController()
              ..text = "${Date!.day}/${Date!.month}/${Date!.year}"),
            minLines: 1,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: Hint_Text,
              labelText: Leble_Text,
              contentPadding: EdgeInsets.only(left: 5),
              hintStyle: TextStyle(color: text_hint_color),
              labelStyle: TextStyle(
                color: text_label_color,
              ),
              filled: true,
              fillColor: text_fill_color,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: text__focus_border_color),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: text__enab_border_color),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      );
    } else if (field == "Text Area") {
      return TextFormField(
        minLines: 1,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: Leble_Text,
          hintText: Hint_Text,
          contentPadding: EdgeInsets.only(left: 5),
          hintStyle: TextStyle(color: text_hint_color),
          labelStyle: TextStyle(
            color: text_label_color,
          ),
          filled: true,
          fillColor: text_fill_color,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: text__focus_border_color),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: text__enab_border_color),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else if (field == "Num") {
      return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5),
          hintText: Hint_Text,
          labelText: Leble_Text,
          hintStyle: TextStyle(color: text_hint_color),
          labelStyle: TextStyle(
            color: text_label_color,
          ),
          filled: true,
          fillColor: text_fill_color,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: text__focus_border_color),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: text__enab_border_color),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      // ===============================    (mobile number )
      return TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5),
          hintText: Hint_Text,
          labelText: Leble_Text,
          hintStyle: TextStyle(color: text_hint_color),
          labelStyle: TextStyle(
            color: text_label_color,
          ),
          filled: true,
          fillColor: text_fill_color,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: text__focus_border_color),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: text__enab_border_color),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  // ______________________________________________________________   (Templet 1)   ____________________________________
  Widget R1({
    required String img,
    String? name,
    required List<Widget> Templates_filds,
    required List<String> Labels,
    required List<String> hints,
    required List<String> fields_name,
  }) {
    return GestureDetector(
      onTap: () {
        // print(labels);
        print("object");
        Get.to(view_Templets(
          Templates_filds: Templates_filds,
          temp_name: name,
          Labels: Labels,
          fields_name: fields_name,
          hints: hints,
        ));
      },
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: BoxBorder.lerp(
                Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                2),
            color: t_color,
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 125,
          width: 210,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(img),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: t_color,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(50)),
                  ),
                  // clipBehavior: Clip.hardEdge,
                  width: 215,
                  height: 20,

                  child: Center(
                      child: Text(
                    "$name",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 3, 3, 3)),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ______________________________________________________________   (Templet 2)   ____________________________________
  Widget S1({
    required String img,
    String? name,
    required List<Widget> Templates_filds,
    required List<String> Labels,
    required List<String> hints,
    required List<String> fields_name,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(view_Templets(
          Templates_filds: Templates_filds,
          temp_name: name,
          Labels: Labels,
          fields_name: fields_name,
          hints: hints,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            border: BoxBorder.lerp(
                Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                2),
            color: body_color,
            borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.all(3),
        child: Container(
          height: 125,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(img),
              fit: BoxFit.cover,
            ),
            color: t_color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: t_color,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(50)),
                  ),
                  // clipBehavior: Clip.hardEdge,
                  width: 105,
                  height: 20,

                  child: Center(
                      child: Text(
                    "$name",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // googleLogin() async {
  //   print("googleLogin method Called");
  //   GoogleSignIn _googleSignIn = GoogleSignIn();
  //   try {
  //     var reslut = await _googleSignIn.signIn();
  //     if (reslut == null) {
  //       return;
  //     }
  //     print("Result $reslut");
  //     print(reslut.displayName);
  //     print(reslut.email);
  //     print(reslut.id);
  //     account_name = reslut.displayName;
  //     account_email = reslut.email;
  //     account_Id = reslut.id;
  //     if (run) {
  //       setState(() {
  //         run = false;
  //       });
  //     }
  //     //
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  Color text_fill_color = Color.fromARGB(255, 255, 255, 255);
  Color t_color = Color.fromARGB(255, 255, 255, 255);
  Color orange_color = Color.fromARGB(255, 250, 79, 0);
  Color text_hint_color = Color.fromARGB(104, 0, 0, 0);
  Color text__enab_border_color = Color.fromARGB(255, 0, 0, 0);
  Color text__focus_border_color = Color.fromARGB(255, 250, 79, 0);
  Color text_label_color = Color.fromARGB(255, 250, 79, 0);
  Color body_color = Color.fromARGB(255, 255, 255, 255);
  // Color body_color = Color.fromARGB(255, 255, 239, 230);

  @override
  bool search = false;
  @override
  Widget build(BuildContext context) {
    final provider_object = Provider.of<my_providers>(context, listen: false);
    String user_name;
    user_name = current_user!.displayName.toString();

    print("User name--------${user_name}== ");

    return WillPopScope(onWillPop: () {
      if (s1) {
        s1 = false;
        setState(() {});
        return Future.value(false);
      } else if (s2) {
        s2 = false;
        setState(() {});
        return Future.value(false);
      }
      return Future.value(true);
    }, child: Consumer<my_providers>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: orange_color,
          // forceMaterialTransparency: true,
          // centerTitle: true,
          title: Text(
            s1
                ? "Trash"
                : s2
                    ? "About Us"
                    : "Resently used",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            s1
                ? SizedBox()
                : s2
                    ? SizedBox()
                    : AnimatedContainer(
                        margin: EdgeInsets.all(5),
                        width: search ? 300 : 45,
                        // height: 10,
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                                // autofocus: true,
                                decoration: InputDecoration(
                                    prefixIcon: IconButton(
                                        onPressed: () {
                                          a = true;
                                          search = false;
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
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                        borderRadius:
                                            BorderRadius.circular(80))),
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
                              ))
          ],
        ),
        drawer: Drawer(
          width: 260,
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: user_name == "null" || user_name == ""
                    ? StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .where("user Id", isEqualTo: current_user!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot != null && snapshot.data != null) {
                            String user_name = snapshot.data!.docs[0]["name"];

                            return Text(user_name);
                          }
                          return SizedBox();
                        },
                      )
                    : Text(current_user!.displayName.toString()),
                // : Text(current_user!.displayName.toString()),
                accountEmail: Text(current_user!.email.toString()),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("lib/assets/images/people.png"),
                  foregroundImage:
                      NetworkImage(current_user!.photoURL.toString()),
                ),
                // Image.asset("lib/assets/images/people.png"),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: Offset(0, 1))
                  ],
                  // color: Color.fromARGB(255, 4, 31, 54),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 0, 0, 0),
                      orange_color,
                    ],
                    // transform: GradientRotation(40),
                    // stops: [0.5, 0],
                  ),
                ),
              ),
              ListTile(
                minLeadingWidth: 50,
                onTap: () {
                  s1 = false;
                  s2 = false;
                  setState(() {});
                  Navigator.pop(context);
                },
                selected: false,
                enabled: true,
                title: Text("Home"),
                leading: Icon(
                  Icons.home,
                  size: 25,
                ),
              ),
              ListTile(
                minLeadingWidth: 50,
                onTap: () {
                  s1 = true;
                  s2 = false;
                  setState(() {});
                  Navigator.pop(context);
                },
                selected: false,
                enabled: true,
                title: Text("Trash"),
                leading: Icon(
                  Icons.delete,
                  size: 25,
                ),
              ),
              ListTile(
                minLeadingWidth: 50,
                onTap: () {
                  s2 = true;
                  s1 = false;
                  setState(() {});
                  Navigator.pop(context);
                },
                selected: false,
                enabled: true,
                title: Text("About Us"),
                leading: Icon(
                  Icons.adb_outlined,
                  size: 25,
                ),
              ),
              ListTile(
                minLeadingWidth: 50,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Are you sure"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            ElevatedButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  logout();
                                  setState(() {});
                                  Get.offAll(Login_Page());
                                },
                                child: Text("OK")),
                          ],
                        );
                      });
                },
                selected: false,
                enabled: true,
                title: Text("Log Out"),
                leading: Icon(
                  Icons.logout_outlined,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
        // endDrawer: InkWell(
        //   onTap: () {
        //     setState(() {});
        //   },
        // ),
        // backgroundColor: Color.fromARGB(255, 6, 1, 27),
        backgroundColor:
            s2 || s1 ? Color.fromARGB(255, 255, 255, 255) : body_color,
        body: Scrollbar(
          child: SingleChildScrollView(
            child: s1
                ? Trash_page()
                : s2
                    ? aboutUs()
                    : Column(
                        children: [
                          // ______________________________________________________________________________   ( recently used templets )    ____________________________________________________________________________________
                          Container(
                              height: 150,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("${current_user?.uid}")
                                      .where("userId",
                                          isEqualTo: current_user?.uid)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text("Something went wrong");
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CupertinoActivityIndicator());
                                    }
                                    if (snapshot.data!.docs.isEmpty) {
                                      return Text(
                                        "No Form",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0)),
                                      );
                                    }
                                    if (snapshot != null &&
                                        snapshot.data != null) {
                                      value.Forms_name.clear();
                                      print(
                                          " aa======== ${snapshot.data!.docs.length}");

                                      if (snapshot.data!.docs.length == 2) {
                                        length_of_Form_name = int.parse(
                                            snapshot.data!.docs[1]["Length"]);
                                        doc_index = 1;
                                      } else {
                                        length_of_Form_name = int.parse(
                                            snapshot.data!.docs[0]["Length"]);
                                        doc_index = 0;
                                      }
                                      print("doc_index = $doc_index");

                                      for (int j = 0;
                                          j < length_of_Form_name;
                                          j++) {
                                        String name = (snapshot.data!
                                                .docs[doc_index][j.toString()])
                                            .toString();
                                        print("name== $name");
                                        value.add_form_name(name);
                                        value.add_colors(Colors.white);
                                      }
                                      // =================================================================    (add trash from firebase)

                                      Trash.clear();
                                      if (doc_index != 0) {
                                        int length_of_Trash = int.parse(
                                            snapshot.data!.docs[0]["Length"]);
                                        for (int i = 0;
                                            i < length_of_Trash;
                                            i++) {
                                          Trash.add(snapshot.data!.docs[0]
                                              [i.toString()]);
                                        }
                                      }

                                      print("Trash items= $Trash");

                                      return Container(
                                        // color: Color.fromARGB(255, 240, 151, 78),
                                        child: ListView.builder(
                                          itemExtent: 105,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              // onLongPress: () async {
                                              //   print("l.................");
                                              //   // FirebaseFirestore.instance
                                              //   //     .collection("${current_user?.uid}")
                                              //   //     .doc(Form_names[index])
                                              //   //     .delete();
                                              //   provider_object.replace_color(index);
                                              //   setState(() {});
                                              // },
                                              onTap: () {
                                                // =================================================================

                                                print(
                                                    "Empty=====${value.Forms_name.isEmpty}");
                                                // =================================================================
                                                Get.to(
                                                  Data_show(
                                                    Form_name: a
                                                        ? snapshot.data!
                                                                .docs[doc_index]
                                                            [index.toString()]
                                                        : search_results[index],
                                                  ),
                                                  transition:
                                                      Transition.topLevel,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInOutCubic,
                                                  // popGesture: true,
                                                  fullscreenDialog: true,
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: orange_color,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 110,
                                                      width: 90,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  // abc = false;
                                                                  // form_name =
                                                                  //     provider_object
                                                                  //             .Forms_name[
                                                                  //         index];

                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          backgroundColor:
                                                                              Colors.white,
                                                                          title:
                                                                              Text(
                                                                            "Delete ${snapshot.data!.docs[doc_index][index.toString()]} ? ",
                                                                            style:
                                                                                TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                                                                          ),
                                                                          content:
                                                                              Text(
                                                                            "Delete ${snapshot.data!.docs[doc_index][index.toString()]} from this device ",
                                                                            style:
                                                                                TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                                                                          ),
                                                                          actions: [
                                                                            TextButton(
                                                                                onPressed: () => Navigator.pop(context),
                                                                                child: Text("Cancel")),
                                                                            TextButton(
                                                                                onPressed: () {
                                                                                  Trash.add(snapshot.data!.docs[doc_index][index.toString()]);

                                                                                  print("Trash ${Trash}");

                                                                                  print("forms names--- ${value.Forms_name}");
                                                                                  if (value.Forms_name.isEmpty) {
                                                                                    print("Empty..........");
                                                                                    // int length_of_Form_name = int.parse(snapshot.data!.docs[doc_index]["Length"]);
                                                                                    for (int j = 0; j < length_of_Form_name; j++) {
                                                                                      print("J== $j");
                                                                                      value.add_form_name(snapshot.data!.docs[doc_index][j.toString()]);
                                                                                    }
                                                                                  }
                                                                                  value.Forms_name.removeAt(index);

                                                                                  Map<String, String> Map_Form_Names = {};
                                                                                  for (int i = 0; i < value.Forms_name.length; i++) {
                                                                                    Map_Form_Names[i.toString()] = value.Forms_name[i];
                                                                                  }
                                                                                  Map_Form_Names["userId"] = current_user!.uid.toString();

                                                                                  Map_Form_Names["Length"] = value.Forms_name.length.toString();
                                                                                  print("Forms Names= ${Map_Form_Names}");
                                                                                  Map<String, String> map_Trash = {};
                                                                                  for (int i = 0; i < Trash.length; i++) {
                                                                                    map_Trash[i.toString()] = Trash[i];
                                                                                  }
                                                                                  map_Trash["userId"] = current_user!.uid.toString();

                                                                                  map_Trash["Length"] = Trash.length.toString();

                                                                                  FirebaseFirestore.instance.collection("${current_user?.uid}").doc("names").set(Map_Form_Names);
                                                                                  FirebaseFirestore.instance.collection("${current_user?.uid}").doc("Trash").set(map_Trash);

                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Text("Delete")),
                                                                          ],
                                                                        );
                                                                      });

                                                                  // // setState(() {});
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .white,
                                                                  shadows: [
                                                                    BoxShadow(
                                                                        blurRadius:
                                                                            3,
                                                                        color: Colors
                                                                            .black)
                                                                  ],
                                                                ),
                                                              )),
                                                          Container(
                                                            // color: Colors.black,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 50),
                                                            child: Center(
                                                              child: Text(
                                                                a
                                                                    ? snapshot
                                                                            .data!
                                                                            .docs[doc_index]
                                                                        [index
                                                                            .toString()]
                                                                    : search_results[
                                                                        index],
                                                                style:
                                                                    TextStyle(
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
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          // color: Color.fromARGB(
                                                          //     255, 83, 83, 83),
                                                          // color: Color.fromARGB(
                                                          // 255, 15, 207, 255),
                                                          color: Color.fromARGB(
                                                              255,
                                                              226,
                                                              171,
                                                              138),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20),
                                                            bottom:
                                                                Radius.circular(
                                                                    60),
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.black,
                                                              blurRadius: 5,
                                                            )
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          scrollDirection: Axis.horizontal,
                                          itemCount: a
                                              ? int.parse(snapshot.data!
                                                  .docs[doc_index]["Length"])
                                              : search_results.length,
                                        ),
                                      );
                                    }
                                    return Container();
                                  })),
                          Divider(
                            thickness: 1,
                            color: Color.fromARGB(255, 3, 70, 90),
                          ),
                          abc ? Delet_form(Name, Trash) : SizedBox(),

                          SizedBox(
                            height: 10,
                          ),
                          // ______________________________________________________________________________   ( templets )    ____________________________________________________________________________________
                          Container(
                            padding: EdgeInsets.all(0),
                            // height: 550,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    R1(
                                        img:
                                            "lib/assets/images/electonic goods.jpg",
                                        name: "Electronic goods",
                                        Templates_filds: [
                                          design_fileds(
                                              Leble_Text: "Costomer Name",
                                              Hint_Text: "enter Costomer Name",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: "sale Date",
                                              Hint_Text: "DD/MM/YYYY",
                                              field: "Date"),
                                          design_fileds(
                                              Leble_Text: "Product",
                                              Hint_Text: "enter Product Name",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: "Price",
                                              Hint_Text: "enter product price ",
                                              field: "Num"),
                                          design_fileds(
                                              Leble_Text: "Quantity",
                                              Hint_Text: "enter Your Name",
                                              field: "Num"),
                                        ],
                                        Labels: [
                                          "Costomer Name",
                                          "sale Date",
                                          "Product",
                                          "Price",
                                          "Quantity"
                                        ],
                                        fields_name: [
                                          "Text",
                                          "Date",
                                          "Text",
                                          "Num",
                                          "Num",
                                        ],
                                        hints: [
                                          "enter Costomer Name",
                                          "DD/MM/YYYY",
                                          "enter Product Name",
                                          "enter product price ",
                                          "enter Your Name"
                                        ]),
                                    S1(
                                        img: "lib/assets/images/marketing.jpg",
                                        name: "Digital Marke",
                                        Templates_filds: [
                                          design_fileds(
                                              Leble_Text: "Program Name",
                                              Hint_Text: "enter Program Name",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: "Docment Name",
                                              Hint_Text: "enter Docment Name",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: "Partner Name",
                                              Hint_Text: "enter Partner Name",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: "Email Address",
                                              Hint_Text: "enter email",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: "Phone Nmber",
                                              Hint_Text: "enter Phone Nmber",
                                              field: "Mobile No"),
                                          design_fileds(
                                              Leble_Text: "Marketing Goals",
                                              Hint_Text: "enter Goals ",
                                              field: "Text Area"),
                                          design_fileds(
                                              Leble_Text: "Meeting Date",
                                              Hint_Text: "enter Date",
                                              field: "Date"),
                                        ],
                                        Labels: [
                                          "Program Name",
                                          "Docment Name",
                                          "Partner Name",
                                          "Email Address",
                                          "Phone Nmber",
                                          "Marketing Goals",
                                          "Meeting Date"
                                        ],
                                        fields_name: [
                                          "Text",
                                          "Text",
                                          "Text",
                                          "Text",
                                          "Mobile No",
                                          "Text Area",
                                          "Date",
                                        ],
                                        hints: [
                                          "enter Program Name",
                                          "enter Docment Name",
                                          "enter Partner Name",
                                          "enter email",
                                          "enter Phone Nmber",
                                          "enter Goals ",
                                          "enter Date"
                                        ]),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    S1(
                                        img: "lib/assets/images/payment.jpg",
                                        name: "Payments",
                                        Templates_filds: [
                                          design_fileds(
                                              Leble_Text: "Name",
                                              Hint_Text: "enter full Name",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: " Date",
                                              Hint_Text: "DD/MM/YYYY",
                                              field: "Date"),
                                          design_fileds(
                                              Leble_Text: "Message",
                                              Hint_Text: "enter some message",
                                              field: "Text Area"),
                                          design_fileds(
                                              Leble_Text: "Phone No.",
                                              Hint_Text: "enter phone no.",
                                              field: "Num"),
                                          design_fileds(
                                              Leble_Text: "Amount",
                                              Hint_Text: "enter amount ",
                                              field: "Num"),
                                        ],
                                        Labels: [
                                          "Name",
                                          "Date",
                                          "Message",
                                          "Phone No.",
                                          "Amount"
                                        ],
                                        fields_name: [
                                          "Text",
                                          "Date",
                                          "Text Area",
                                          "Num",
                                          "Num",
                                        ],
                                        hints: [
                                          "enter full Name",
                                          "DD/MM/YYYY",
                                          "enter some message",
                                          "enter phone no.",
                                          "enter amount "
                                        ]),
                                    R1(
                                        img: "lib/assets/images/mar.jpg",
                                        name: "internet Connection",
                                        Templates_filds: [
                                          design_fileds(
                                              Leble_Text: "Costomer Name",
                                              Hint_Text: "enter Costomer Name",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: "sale Date",
                                              Hint_Text: "DD/MM/YYYY",
                                              field: "Date"),
                                          design_fileds(
                                              Leble_Text: "Product",
                                              Hint_Text: "enter Product Name",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: "Price",
                                              Hint_Text: "enter product price ",
                                              field: "Num"),
                                          design_fileds(
                                              Leble_Text: "Quantity",
                                              Hint_Text: "enter Your Name",
                                              field: "Num"),
                                        ],
                                        Labels: [
                                          "Costomer Name",
                                          "sale Date",
                                          "Product",
                                          "Price",
                                          "Quantity"
                                        ],
                                        fields_name: [
                                          "Text",
                                          "Date",
                                          "Text",
                                          "Num",
                                          "Num",
                                        ],
                                        hints: [
                                          "enter Costomer Name",
                                          "DD/MM/YYYY",
                                          "enter Product Name",
                                          "enter product price ",
                                          "enter Your Name"
                                        ]),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    R1(
                                        img: "lib/assets/images/cab2.jpg",
                                        name: "Cable Connection",
                                        Templates_filds: [
                                          design_fileds(
                                              Leble_Text: "Costomer Name",
                                              Hint_Text: "enter Cost. Name",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: "Area",
                                              Hint_Text:
                                                  "enter costomer address",
                                              field: "Text Area"),
                                          design_fileds(
                                              Leble_Text: "Plan",
                                              Hint_Text: "enter plan Name",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: "LCO",
                                              Hint_Text: "enter LCO number",
                                              field: "Num"),
                                          design_fileds(
                                              Leble_Text: "STB / Mac No.",
                                              Hint_Text: "enter STB / Mac No.",
                                              field: "Num"),
                                          design_fileds(
                                              Leble_Text: "Phone No.",
                                              Hint_Text:
                                                  "enter costomer phone No.",
                                              field: "Mobile No"),
                                          design_fileds(
                                              Leble_Text: "Recharge Date",
                                              Hint_Text: "DD/MM/YYYY",
                                              field: "Date"),
                                          design_fileds(
                                              Leble_Text: "Expiry Date",
                                              Hint_Text: "DD/MM/YYYY",
                                              field: "Date"),
                                          design_fileds(
                                              Leble_Text: "Payment",
                                              Hint_Text: "enter payment",
                                              field: "Num"),
                                          design_fileds(
                                              Leble_Text: "Due",
                                              Hint_Text: "enter Due payment",
                                              field: "Num"),
                                        ],
                                        Labels: [
                                          "Costomer Name",
                                          "Area",
                                          "LCO",
                                          "STB / Mac No.",
                                          "Phone No.",
                                          "Plan",
                                          "recharge Date",
                                          "Expiry Date",
                                          "Payment",
                                          "Due",
                                        ],
                                        fields_name: [
                                          "Text",
                                          "Text Area",
                                          "Num",
                                          "Num",
                                          "Text",
                                          "Mobile No",
                                          "Date",
                                          "Date",
                                          "Num",
                                          "Num",
                                        ],
                                        hints: [
                                          "enter Costomer Name",
                                          "enter costomer address",
                                          "enter LCO number",
                                          "enter STB / Mac No.",
                                          "enter costomer phone No.",
                                          "enter plan Name",
                                          "DD/MM/YYYY",
                                          "DD/MM/YYYY",
                                          "enter payment",
                                          "enter Due payment"
                                        ]),
                                    S1(
                                        img: "lib/assets/images/Rent4.png",
                                        name: "Rent",
                                        Templates_filds: [
                                          design_fileds(
                                              Leble_Text: "Costomer Name",
                                              Hint_Text: "enter Costomer Name",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: "sale Date",
                                              Hint_Text: "DD/MM/YYYY",
                                              field: "Date"),
                                          design_fileds(
                                              Leble_Text: "Product",
                                              Hint_Text: "enter Product Name",
                                              field: "Text"),
                                          design_fileds(
                                              Leble_Text: "Price",
                                              Hint_Text: "enter product price ",
                                              field: "Num"),
                                          design_fileds(
                                              Leble_Text: "Quantity",
                                              Hint_Text: "enter Your Name",
                                              field: "Num"),
                                        ],
                                        Labels: [
                                          "Costomer Name",
                                          "sale Date",
                                          "Product",
                                          "Price",
                                          "Quantity"
                                        ],
                                        fields_name: [
                                          "Text",
                                          "Date",
                                          "Text",
                                          "Num",
                                          "Num",
                                        ],
                                        hints: [
                                          "enter Costomer Name",
                                          "DD/MM/YYYY",
                                          "enter Product Name",
                                          "enter product price ",
                                          "enter Your Name"
                                        ])
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // ______________________________________________________________________________   ( Floating Button )    ____________________________________________________________________________________

        floatingActionButton: s1 || s2
            ? Container(
                margin: EdgeInsets.all(20),
                child: FloatingActionButton(
                    elevation: 20,
                    backgroundColor: orange_color,
                    onPressed: () {
                      s1 = false;
                      s2 = false;
                      setState(() {});
                    },
                    child: Icon(
                      Icons.home,
                      color: Color.fromARGB(255, 255, 255, 255),
                    )),
              )
            : Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                ),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    // Filds_Names.clear();
                    // Text_Filds_Lable.clear();
                    // Text_Filds_Hint.clear();
                    // Form_Fields.clear();

                    Form_name_Controler.text =
                        "Form ${(value.Forms_name.length + 1).toString()}";
                    // setState(() {});
                    // Form_name = "form" + "${a.toString()}";

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
                              // autofocus: true,
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
                                  // Form_names.add(Form_name_Controler.text);

                                  // Form_names.insert(0, Form_name_Controler.text);

                                  print(value.Forms_name);
                                  setState(() {
                                    // a++;
                                    Dcolor = true;
                                  });
                                  if (Trash.contains(
                                      Form_name_Controler.text.trim())) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            " Error... ",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          content: Text(
                                            'That form here in your trash please remove this form in your trash Can you delete this form on your trash Click on "Delete". ',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancel")),
                                            TextButton(
                                                onPressed: () {
                                                  Name = Form_name_Controler
                                                      .text
                                                      .trim();
                                                  abc = true;
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Delete"))
                                          ],
                                        );
                                      },
                                    );
                                  } else if (Form_name_Controler.text.trim() ==
                                      "") {
                                    Get.snackbar(
                                      "Error",
                                      "Form name can't be empty please enter form name",
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 0, 0),
                                      barBlur: 5,
                                      colorText:
                                          Color.fromARGB(255, 255, 255, 255),
                                    );
                                  } else if (value.Forms_name.contains(
                                      Form_name_Controler.text.trim())) {
                                    Get.snackbar(
                                      "Error",
                                      "Form name is already here in your form list please change your form name then continu your build form.",
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 0, 0),
                                      barBlur: 5,
                                      colorText:
                                          Color.fromARGB(255, 255, 255, 255),
                                    );
                                  } else {
                                    Get.off(New_Form(
                                      Form_name:
                                          Form_name_Controler.text.trim(),
                                      All_Forms_Names: value.Forms_name,
                                      update: true,
                                      Trash: Trash,
                                      // Filds_Name: Filds_Names,
                                    ));
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
                    "New Form",
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
      );
    }));
  }
}

// class entrys {
//   List<String> labels = [];
//   List<String> hints = [];
//   List<String> fields_name = [];
// }
