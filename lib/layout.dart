// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

// import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  Future<void> _export_to_Excel() async {
    final workbook1 = Workbook();
    final Worksheet sheet = workbook1.worksheets[0];
    sheet.getRangeByName('A1').setText('Hello World');
    sheet.getRangeByName('B3').setText('Hello World');
    final List<int> bytes = workbook1.saveAsStream();
    workbook1.dispose();
    var dir = await DownloadsPathProvider.downloadsDirectory;

    print("new path :- ${dir?.path}");

    final String fileName = '${dir!.path}/output3.xlsx';
    final File file = File(fileName);
    print("aa***");

    await file.writeAsBytes(bytes);
    print("Done...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color.fromARGB(255, 191, 247, 113),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            // _export_to_Excel();
            PermissionStatus storage_per = await Permission.storage.request();
            if (storage_per == PermissionStatus.granted) {
              _export_to_Excel();
            }
            if (storage_per == PermissionStatus.denied) {
              await Permission.storage.request();
              // openAppSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("This permission is recommended")));
            }
            if (storage_per == PermissionStatus.permanentlyDenied) {
              // openAppSettings();
              openAppSettings();
            }

            // // add_column("Name");

            // setState(() {});
          },
          label: Icon(Icons.add)),
    );
  }
}
