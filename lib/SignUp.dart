import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_nest2/Login.dart';
import 'package:list_nest2/Templets.dart';
import './services.dart';

class Sign_Up_Page extends StatefulWidget {
  Sign_Up_Page({super.key});

  @override
  State<Sign_Up_Page> createState() => _Sign_Up_PageState();
}

class _Sign_Up_PageState extends State<Sign_Up_Page> {
  bool ab = true;
  bool abc = true;

  final _SingUp_key = GlobalKey<FormState>();

  TextEditingController user_name_con = TextEditingController();

  var user_Email_con = TextEditingController();

  var user_phone_no_con = TextEditingController();
  var confirm_password_con = TextEditingController();

  var user_password_con = TextEditingController();

  Color text_fill_color = Color.fromARGB(255, 255, 255, 255);
  Color orange_color = Color.fromARGB(255, 255, 96, 23);
  Color text_hint_color = Color.fromARGB(104, 0, 0, 0);
  Color text__enab_border_color = Color.fromARGB(255, 0, 0, 0);
  // Color text__focus_border_color = Color.fromARGB(255, 8, 247, 255);
  Color text__focus_border_color = Color.fromARGB(255, 4, 142, 255);
  Color text_label_color = Color.fromARGB(255, 0, 0, 0);
  Color body_color = Color.fromARGB(255, 255, 239, 230);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 1, 11, 20),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 0,
          left: 30,
          right: 30,
        ),
        decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [
            //       Color.fromARGB(255, 1, 11, 20),
            //       Color.fromARGB(255, 4, 31, 54),
            //     ],
            //     transform: GradientRotation(40),
            //     // stops: [0.5, 0],
            //   ),
            color: body_color),
        child: Center(
            child: SingleChildScrollView(
          child: Form(
            key: _SingUp_key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up ",
                  style: TextStyle(
                      color: orange_color,
                      // fontWeight: FontWeight.bold,
                      fontSize: 50),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "See you growth and get consulting support ",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      // fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: user_name_con,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'please enter your User Name';
                      }
                      return null;
                    },
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    cursorColor: const Color.fromARGB(255, 0, 0, 0),
                    autofocus: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: text_fill_color,
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                      labelText: "User Name",
                      labelStyle: TextStyle(color: text_label_color),
                      prefixText: "  ",
                      hintText: "Full Name",
                      hintStyle: TextStyle(color: text_hint_color),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: text__focus_border_color,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: text__enab_border_color,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: user_Email_con,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'please enter your Email - Id';
                      } else if (GetUtils.isEmail(value) != true) {
                        return 'incorrect email format';
                      }
                      return null;
                    },
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    cursorColor: const Color.fromARGB(255, 0, 0, 0),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: text_fill_color,
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(color: text_label_color),
                      prefixText: "  ",
                      hintText: "Enter Your Email id",
                      hintStyle: TextStyle(color: text_hint_color),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: text__focus_border_color,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: text__enab_border_color,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: user_password_con,
                    validator: (value) {
                      if (value!.isEmpty || value == null || value.length < 6) {
                        if (value.isEmpty) {
                          return 'please enter your Password';
                        } else if (value.length < 6) {
                          return 'minimum length of password 6 is required ';
                        }
                      }
                      return null;
                    },
                    obscureText: abc,
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    cursorColor: const Color.fromARGB(255, 0, 0, 0),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: text_fill_color,
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: text_label_color),
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (abc == true) {
                              abc = false;
                              setState(() {});
                            } else {
                              abc = true;
                              setState(() {});
                            }
                          },
                          icon: Icon(
                            abc == true
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye,
                            color: abc
                                ? Color.fromARGB(124, 0, 0, 0)
                                : const Color.fromARGB(255, 0, 0, 0),
                          )),
                      prefixText: "  ",
                      hintText: "Enter Your Password",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(118, 255, 255, 255)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: text__focus_border_color,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: text__enab_border_color,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: confirm_password_con,
                    validator: (value) {
                      if (value!.isEmpty || value == null || value.length < 6) {
                        if (value.isEmpty) {
                          return 'please enter your Password for confirmation';
                        } else if (value.length < 6) {
                          return 'minimum length of password 6 is required ';
                        }
                      } else if (user_password_con.text != value) {
                        return "incorrect password";
                      }
                      return null;
                    },
                    obscureText: ab,
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    cursorColor: const Color.fromARGB(255, 0, 0, 0),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: text_fill_color,
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (ab == true) {
                              ab = false;
                              setState(() {});
                            } else {
                              ab = true;
                              setState(() {});
                            }
                          },
                          icon: Icon(
                            ab == true
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye,
                            color: ab
                                ? Color.fromARGB(124, 0, 0, 0)
                                : const Color.fromARGB(255, 0, 0, 0),
                          )),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(color: text_label_color),
                      prefixText: "  ",
                      hintText: "Confirm Your Password",
                      hintStyle: TextStyle(color: text_hint_color),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: text__focus_border_color,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: text__enab_border_color,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: user_phone_no_con,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'please enter your Phone Number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    cursorColor: const Color.fromARGB(255, 0, 0, 0),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: text_fill_color,
                      labelText: "Phone No",
                      labelStyle: TextStyle(color: text_label_color),
                      prefixText: "  ",
                      hintText: "Enter Your Phone number",
                      hintStyle: TextStyle(color: text_hint_color),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: text__focus_border_color,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(
                          color: text__enab_border_color,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  // borderRadius: BorderRadius.circular(100),
                  onTap: () async {
                    if (_SingUp_key.currentState!.validate()) {
                      print("validated");
                      var user_name = user_name_con.text.trim();
                      var user_Email = user_Email_con.text.trim();
                      var user_phone_no = user_phone_no_con.text.trim();
                      var user_password = user_password_con.text.trim();
                      // Sign_up_service(
                      //   user_name,
                      //   user_Email,
                      //   user_phone_no,
                      //   user_password,
                      // );

                      try {
                        UserCredential user1 =
                            // current_user:
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                          email: user_Email,
                          password: user_password,
                        );

                        Get.to(Sign_Up_services(
                          user_email: user_Email,
                          user_name: user_name,
                          user_password: user_password,
                          user_phone_no: user_password,
                        ));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          Get.snackbar(
                              "Error", "password provided is too weak");
                        } else if (e.code == 'email-already-in-use') {
                          Get.snackbar("Error", "this account already used");
                        } else if (e.code == 'user-not-found') {
                          Get.snackbar("Error", "faike email");
                        } else {
                          Get.snackbar("Error", e.toString());
                        }
                      }

                      // FirebaseAuth.instance.signOut();

                      // for (; current_user!.emailVerified != true;) {
                      //   print("check email.......");
                      //   setState(() {});
                      // }

                      // await FirebaseFirestore.instance
                      //     .collection("users")
                      //     .doc(current_user?.uid)
                      //     .set({
                      //   "name": user_name,
                      //   "email": user_Email,
                      //   "phone No": user_phone_no,
                      //   "user Id": current_user?.uid,
                      //   "password": user_password
                      // }).then((value) =>
                      //         {print("user Id : ${current_user?.uid}")});
                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //     content: Text("Your account has been created")));
                      // Get.off(Templets_page(),
                      //     transition: Transition.cupertino);
                    } else {
                      print("Not validate");
                    }

                    print("object");
                  },

                  child: Container(
                    height: 60,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: orange_color),
                    child: Center(
                        child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.off(Login_Page(), transition: Transition.leftToRight);
                    print("object");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Already Have a Account",
                        style: TextStyle(
                          color: Color.fromARGB(133, 0, 0, 0),
                        ),
                      ),
                      Text(
                        " Sign in",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
