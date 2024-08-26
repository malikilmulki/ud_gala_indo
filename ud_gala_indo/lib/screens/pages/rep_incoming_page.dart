import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:excel/excel.dart';
import 'package:open_file/open_file.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class ReportIncomingPage extends StatelessWidget {
  final List<Map<String, dynamic>> dataList = [
    {"No": 1, "Nama": "John", "Jenis Kelamin": "Male", "Tanggal Masuk": "2023-01-01", "Berat": 70.5, "Status": "Active"},
    {"No": 2, "Nama": "Jane", "Jenis Kelamin": "Female", "Tanggal Masuk": "2023-02-01", "Berat": 60.0, "Status": "Inactive"},
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Export Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => exportToPdf(context),
              child: Text('Export to PDF'),
            ),
            ElevatedButton(
              onPressed: () => exportToExcel(),
              child: Text('Export to Excel'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> exportToPdf(BuildContext context) async {
    final pdf = pw.Document();

    final fontData = await rootBundle.load("assets/fonts/muli/Muli.ttf");
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            headers: dataList.first.keys.toList(),
            data: dataList.map((item) => item.values.toList()).toList(),
            cellStyle: pw.TextStyle(font: ttf), // Use custom font here
            headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
          );
        },
      ),
    );

    await saveFileToInternalStorage(await pdf.save(), 'incoming.pdf');
  }

  Future<void> exportToExcel() async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    sheetObject.appendRow(dataList.first.keys.toList()); // Add header
    for (var row in dataList) {
      sheetObject.appendRow(row.values.toList());
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/output.xlsx');

    await saveFileToInternalStorage(Uint8List.fromList(excel.save()!), 'incoming.xlsx');
  }

  Future<void> saveFileToInternalStorage(Uint8List bytes, String fileName) async {
    final directory = await getDownloadsDirectory(); // Internal storage directory
    final filePath = '${directory!.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      print('File exists');
    } else {
      print('File does not exist');
    }
    print('File saved at: $filePath');

    OpenFile.open(filePath, linuxByProcess: true); // Attempt to open the file
  }
}
