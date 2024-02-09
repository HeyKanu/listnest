import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'dart:io';

class Export_To_Excel {
  Future<void> export_to_Excel(
      String name, List<List> user_data, List<String> labels) async {
    try {
      final workbook1 = Workbook();
      final Worksheet sheet = workbook1.worksheets[0];
      var column = 'A'.codeUnitAt(0);

      for (var i = 0; i < labels.length; i++) {
        sheet
            .getRangeByName("${String.fromCharCode(column)}1")
            .setText(labels[i]);
        column++;
      }
      var column_range = 'A'.codeUnitAt(0);
      var a = column_range + labels.length - 1;

      sheet
          .getRangeByName('A1:${String.fromCharCode(a)}1')
          .cellStyle
          .backColor = '#333F4F';
      sheet
          .getRangeByName('A1:${String.fromCharCode(a)}1')
          .cellStyle
          .fontColor = '#ffffff';
      sheet.getRangeByName('A1:${String.fromCharCode(a)}1').cellStyle.bold =
          true;

      for (var i = 0, abc = 2; i < user_data.length; i++, abc++) {
        var column = 'A'.codeUnitAt(0);
        for (var j = 0; j < user_data[i].length - 1; j++) {
          sheet
              .getRangeByName("${String.fromCharCode(column)}${abc}")
              .setText(user_data[i][j]);
          column++;
        }
      }

      // sheet.getRangeByName('B3').setText('Hello World');
      final List<int> bytes = workbook1.saveAsStream();
      workbook1.dispose();
      var dir = await DownloadsPathProvider.downloadsDirectory;

      print("new path :- ${dir?.path}");

      final String fileName = '${dir!.path}/$name.xlsx';
      final File file = File(fileName);
      print("aa***");

      await file.writeAsBytes(bytes);
      print("Done...");
      Get.snackbar(
        "Export Complet",
        "Save on your Downlode folder",
        backgroundColor: Color.fromARGB(255, 255, 193, 7),
        barBlur: 5,
        colorText: Color.fromARGB(255, 0, 0, 0),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Somthing went wrong",
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        barBlur: 5,
        colorText: Color.fromARGB(255, 255, 255, 255),
      );
    }
  }
}

class Export_To_PDf {
  Future<void> export_to_pdf(List<String> label, String? form_name,
      List<List> user_data, String file_name) async {
    try {
      PdfDocument document = PdfDocument();
      // document.pages.add().graphics.drawString(
      //     'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 12),
      //     brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      //     bounds: const Rect.fromLTWH(0, 0, 150, 20));

      final page = document.pages.add(); // add page in pdf
      page.graphics.drawString(
          form_name.toString(),
          PdfStandardFont(
            PdfFontFamily.helvetica,
            12,
          ),
          bounds: const Rect.fromLTWH(220, 0, 0, 0));

      PdfGrid grid = PdfGrid();
      grid.style = PdfGridStyle(
          cellPadding: PdfPaddings(bottom: 5, left: 50, right: 5, top: 5));
      grid.columns.add(count: label.length);

      PdfGridRow header = grid.headers.add(1)[0];
      for (var i = 0; i < label.length; i++) {
        header.cells[i].value = label[i];
      }
      header
        ..style.font = PdfStandardFont(PdfFontFamily.helvetica, 10,
            style: PdfFontStyle.bold);

      PdfGridRow row = grid.rows.add();
      print("len =${user_data.length}");
      for (var i = 0; i < user_data.length; i++) {
        // print("I=${user_data[i].length}");
        for (var j = 0; j < user_data[i].length - 1; j++) {
          print("J=$j");
          row.cells[j].value = "${user_data[i][j]}";
        }
        row = grid.rows.add();

        print("...");
      }

      grid.draw(page: page, bounds: Rect.fromLTRB(0, 40, 0, 0));

      var bytes = document.save();
      var dir = await DownloadsPathProvider.downloadsDirectory;
      final String fileName = '${dir!.path}/$file_name.pdf';
      //  final File file = File(fileName);
      print("aa***");
      File(fileName).writeAsBytesSync(await bytes);
      document.dispose();
      // await file..writeAsBytesSync(bytes);
      print("Done...");
      Get.snackbar(
        "Export Complet",
        "Save on your Downlode folder",
        backgroundColor: Color.fromARGB(255, 255, 193, 7),
        barBlur: 5,
        colorText: Color.fromARGB(255, 0, 0, 0),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Somthing went wrong",
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        barBlur: 5,
        colorText: Color.fromARGB(255, 255, 255, 255),
      );
    }
  }
}
