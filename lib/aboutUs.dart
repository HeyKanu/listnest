import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget aboutUs() {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        child: Stack(
          children: [
            Container(
                // width: double.infinity,
                margin: EdgeInsets.only(top: 10, left: 5, right: 150),
                child: Image.asset("lib/assets/images/Untitled-1.png")),
            Container(
              // width: double.infinity,
              margin: EdgeInsets.only(top: 51, left: 10, right: 0),
              child: Text(
                "Unleash Your Data, Anytime, Anywhere with List Nest!",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      // Divider(
      //   // endIndent: 60,
      //   // thickness: 3,
      //   color: const Color.fromARGB(255, 5, 5, 5),
      // ),
      Container(
        // width: double.infinity,
        margin: EdgeInsets.only(
          top: 20,
          left: 30,
        ),
        child: Text(
          "At List Nest, we're committed to transforming the way you manage data on your mobile device. Say goodbye to the constraints of traditional spreadsheets and embrace a new era of productivity with our feature-rich and user-friendly application.",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
        ),
      ),
      Container(
          width: 120,
          margin: EdgeInsets.only(
            top: 20,
            left: 5,
          ),
          child: Image.asset("lib/assets/images/key.png")),

      Container(
          // width: 120,
          margin: EdgeInsets.only(
            top: 10,
            left: 20,
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                margin: EdgeInsets.only(right: 5),
                child: Image.asset("lib/assets/images/dot.png"),
              ),
              Text(
                "Effortless Data Management :-",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
      Container(
        margin: EdgeInsets.only(top: 5, left: 40, right: 10),
        child: Text(
          "List Nest is your go-to mobile app for seamlessly organizing and managing data. Create and edit lists, track information, and stay on top of your tasks effortlessly.",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
        ),
      ),

      Container(
          // width: 120,
          margin: EdgeInsets.only(
            top: 10,
            left: 20,
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                margin: EdgeInsets.only(right: 5),
                child: Image.asset("lib/assets/images/dot.png"),
              ),
              Text(
                "Excel-Like Functionality :-",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
      Container(
        margin: EdgeInsets.only(top: 5, left: 40, right: 10),
        child: Text(
          "Enjoy the power of MS Excel in the palm of your hand. List Nest provides Excel-compatible features, ensuring a smooth transition from your desktop to your mobile device.",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
        ),
      ),

      Container(
          // width: 120,
          margin: EdgeInsets.only(
            top: 10,
            left: 20,
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                margin: EdgeInsets.only(right: 5),
                child: Image.asset("lib/assets/images/dot.png"),
              ),
              Text(
                "Cloud Sync and Collaboration :-",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
      Container(
        margin: EdgeInsets.only(top: 5, left: 40, right: 10),
        child: Text(
          "Sync your lists effortlessly across devices and collaborate with your team in real-time. Access your data from the cloud, keeping everyone on the same page.",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
        ),
      ),

      Container(
          // width: 120,
          margin: EdgeInsets.only(
            top: 10,
            left: 20,
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                margin: EdgeInsets.only(right: 5),
                child: Image.asset("lib/assets/images/dot.png"),
              ),
              Text(
                "Intuitive Interface :-",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
      Container(
        margin: EdgeInsets.only(top: 5, left: 40, right: 10),
        child: Text(
          "Our user-friendly interface is designed for simplicity without compromising functionality. Navigate through your lists, apply filters, and perform calculations with ease.",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
        ),
      ),
    ],
  );
}
