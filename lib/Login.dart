// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_nest2/SignUp.dart';
import 'package:list_nest2/Templets.dart';
import './forget_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Login_Page extends StatefulWidget {
  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  @override
  bool ab = true, loder = false, email_error = false;

  var email_con = TextEditingController();

  var password_con = TextEditingController();
  User? current_user = FirebaseAuth.instance.currentUser;

  final _login_key = GlobalKey<FormState>();
  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  googleLogin() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut == null) {
        return;
      }
      print("Result $reslut");
      print(reslut.displayName);
      print(reslut.email);
      print(reslut.id);

      EasyLoading.show();
      final userData = await reslut.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      EasyLoading.dismiss();

      print("googleLogin method Called.......................");
      EasyLoading.show();
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      //  await FirebaseAuth.instance
      //                       .createUserWithEmailAndPassword(
      //                 email: reslut.email,
      //                 password: user_password,
      //               );

      await FirebaseFirestore.instance.collection("users").doc(reslut.id).set({
        "name": reslut.displayName,
        "email": reslut.email,
        "account Id": reslut.id,
        "user Id": current_user?.uid
      });
      Get.off(Templets_page(), transition: Transition.rightToLeft);
    } catch (error) {
      print(error);
    }
  }

  // Color text_fill_color = Color.fromARGB(255, 216, 216, 216);
  // Color text_fill_color = Color.fromARGB(255, 151, 151, 151);
  Color text_fill_color = Color.fromARGB(255, 255, 255, 255);
  Color text_hint_color = Color.fromARGB(104, 0, 0, 0);
  Color text__enab_border_color = Color.fromARGB(255, 0, 0, 0);
  Color text_label_color = Color.fromARGB(255, 0, 0, 0);
  Color text__focus_border_color = Color.fromARGB(255, 4, 142, 255);

  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 1, 11, 20),
        body: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 239, 230),
        // color: Color.fromARGB(255, 255, 255, 255),
        // gradient: LinearGradient(
        //     colors: [
        //       Color.fromARGB(255, 255, 96, 23),
        //       Color.fromARGB(255, 255, 255, 255),
        //       Color.fromARGB(255, 255, 96, 23),
        //     ],
        //     transform: GradientRotation(3.5),
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter

        //     // stops: [00, 0],
        //     ),
      ),
      child: Center(
          child: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.all(15),
          // color: Colors.yellow,
          height: 560,
          width: 300,
          child: Form(
            key: _login_key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login ",
                  style: TextStyle(
                      shadows: [
                        // BoxShadow(
                        //     color: Color.fromARGB(255, 0, 0, 0),
                        //     blurRadius: 15,
                        //     offset: Offset(0, 7))
                      ],
                      color: Color.fromARGB(255, 255, 96, 23),
                      // fontWeight: FontWeight.bold,
                      fontSize: 50),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "See you growth and get consulting support ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      // fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  // height: 70,
                  decoration: BoxDecoration(
                      // color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        // BoxShadow(
                        //     color: Colors.black,
                        //     blurRadius: 10,
                        //     offset: Offset(0, 7))
                      ]),
                  margin: EdgeInsets.only(top: 30),
                  child: TextFormField(
                    autofocus: true,
                    controller: email_con,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'please enter your Email - Id';
                      } else if (GetUtils.isEmail(value) != true) {
                        return 'incorrect email format';
                      }
                      return null;
                    },
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                      labelText: "Email Id",
                      labelStyle: TextStyle(color: text_label_color),
                      prefixText: "  ",
                      hintText: "Enter Your Email Id",
                      hintStyle: TextStyle(color: text_hint_color),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(color: text__focus_border_color),
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
                  decoration: BoxDecoration(
                      // color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        // BoxShadow(
                        //     color: Colors.black,
                        //     blurRadius: 10,
                        //     offset: Offset(0, 7))
                      ]),
                  margin: EdgeInsets.only(top: 30),
                  child: TextFormField(
                    autofocus: true,
                    controller: password_con,
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
                    obscureText: ab,
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
                                ? Color.fromARGB(101, 0, 0, 0)
                                : Color.fromARGB(255, 0, 0, 0),
                          )),
                      labelText: "Password",
                      labelStyle: TextStyle(color: text_label_color),
                      prefixText: "  ",
                      hintText: "Enter Your Password",
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
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(Forget_password());
                      },
                      child: Text(
                        "Forget Password",
                        style: TextStyle(color: Color.fromARGB(166, 0, 0, 0)),
                      ),
                    )
                  ],
                ),
                email_error
                    ? Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "check Email and password",
                          style: TextStyle(
                              color: Color.fromARGB(166, 255, 0, 0),
                              fontSize: 12),
                        ),
                      )
                    : SizedBox(),
                loder
                    ? Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        )),
                      )
                    : GestureDetector(
                        // borderRadius: BorderRadius.circular(100),
                        onTap: () async {
                          if (_login_key.currentState!.validate()) {
                            print("validated");
                            String email_text = email_con.text.trim();
                            String password_text = password_con.text.trim();
                            try {
                              loder = true;
                              setState(() {});
                              final User? firebaseUser = (await FirebaseAuth
                                      .instance
                                      .signInWithEmailAndPassword(
                                          email: email_text,
                                          password: password_text))
                                  .user;

                              if (firebaseUser != null) {
                                Get.off(Templets_page());
                              } else {
                                print("check Email and password");
                              }
                            } on FirebaseAuthException catch (e) {
                              print("Error : check Email and password");
                              email_error = true;
                              setState(() {});
                              loder = false;
                              setState(() {});
                            }
                            ;
                          } else {
                            email_error = false;
                            setState(() {});
                            print("Not validate");
                          }

                          print("object");
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            boxShadow: [
                              // BoxShadow(
                              //     color: Colors.black,
                              //     offset: Offset(0, 7),
                              //     blurRadius: 10)
                            ],
                            borderRadius: BorderRadius.circular(90),
                            color: Color.fromARGB(255, 252, 104, 19),
                            // color: Colors.cyanAccent,
                          ),
                          child: Center(
                              child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          )),
                        ),
                      ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    " OR",
                    style: TextStyle(color: Color.fromARGB(255, 3, 3, 3)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("object");
                    // logout();

                    googleLogin();
                    // EasyLoading.show();
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(90),
                        boxShadow: [
                          // BoxShadow(
                          //     color: Colors.black,
                          //     blurRadius: 7,
                          //     offset: Offset(0, 7))
                        ]
                        // color: Colors.white,
                        ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child:
                              Image.asset("lib/assets/images/google logo.png"),
                          height: 20,
                          width: 20,
                        ),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        )
                      ],
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(Sign_Up_Page());
                    print("object");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Don't have an account",
                        style: TextStyle(
                          color: Color.fromARGB(133, 0, 0, 0),
                        ),
                      ),
                      Text(
                        " Sign Up",
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
          // color: Colors.white,
        ),
      )),
    ));
  }
}
