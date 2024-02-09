import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:list_nest2/Templets.dart';
import 'package:lottie/lottie.dart';

class Sign_Up_services extends StatefulWidget {
  String user_name;
  String user_email;
  String user_phone_no;
  String user_password;
  Sign_Up_services(
      {required this.user_email,
      required this.user_name,
      required this.user_password,
      required this.user_phone_no});

  @override
  State<Sign_Up_services> createState() => _Google_servicesState();
}

class _Google_servicesState extends State<Sign_Up_services> {
  final auth = FirebaseAuth.instance;
  User? user;
  late Timer timer;
  @override
  void initState() {
    // UserCredential user1 =
    //     // current_user:
    //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //   email: widget.user_email,
    //   password: widget.user_password,
    // );
    // TODO: implement initState
    user = auth.currentUser;
    print("User == $user");
    if (user != null) {
      user!.sendEmailVerification();
      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        check_Email_Verified();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Lottie.asset("lib/assets/images/sand email.json"),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "We've sent an email to ${widget.user_email} to verify your email address and active your account. The link in the email will expire in 24 hours.",
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                      width: 300,
                      height: 300,
                      child: Lottie.asset("lib/assets/images/loder.json")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> check_Email_Verified() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer.cancel();

      await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
        "name": widget.user_name,
        "email": widget.user_email,
        "phone No": widget.user_phone_no,
        "user Id": user?.uid,
        "password": widget.user_password
      }).then((value) => {print("user Id : ${user?.uid}")});

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Templets_page(),
      ));
    }
  }
}
// User? current_user = FirebaseAuth.instance.currentUser;
/*
Sign_up_service(
  String user_name,
  String user_email,
  String user_phone_no,
  String user_password,
) async {
  // await FirebaseAuth.instance
  //     .createUserWithEmailAndPassword(
  //       email: user_email,
  //       password: user_password,
  //     )
  //     .then((value) => {print("connect")});
  try {
    UserCredential user1 =
        // current_user:
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user_email,
      password: user_password,
    );
    User? current_user = FirebaseAuth.instance.currentUser;
    current_user:
    user1;
    if (current_user!.emailVerified == false) {
      await current_user.sendEmailVerification();
    }
    // .then((value) => {print("connect")});
    // await current_user?.sendEmailVerification().then((value) => (value) {
    //       print("request send..");
    //     });
    print("verified--- ${current_user.emailVerified}");
    await FirebaseFirestore.instance
        .collection("users")
        .doc(current_user?.uid)
        .set({
      "name": user_name,
      "email": user_email,
      "phone No": user_phone_no,
      "user Id": current_user?.uid,
      "password": user_password
    }).then((value) => {print("user Id : ${current_user?.uid}")});
    Get.off(Templets_page(), transition: Transition.cupertino);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Get.snackbar("wrong", "password provided is too weak");
    } else if (e.code == 'email-already-in-use') {
      Get.snackbar("wrong", "account provided already Exists");
    } else if (e.code == 'user-not-found') {
      Get.snackbar("wrong", "faike email");
    }
  }
}*/
