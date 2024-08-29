import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart' hide Border;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/remote_report_bloc.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/remote_report_event.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/remote_report_state.dart';
import 'package:ud_gala_indo/injection_container.dart';
import 'package:ud_gala_indo/models/report_model.dart';

class ReportStockPage extends StatefulWidget {
  @override
  _ReportStockPageState createState() => _ReportStockPageState();
}

class _ReportStockPageState extends State<ReportStockPage> {
  late List<ReportModel> dtList;

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white),
            color:Theme.of(context).primaryColor
        ),
        child: Center(
          child: BlocProvider<RemoteReportBloc>(
            create: (context) => sl()..add(GetYearlyOutgoing()),
            child: Scaffold(
                body: _buildBody()
            ),
          ),
        )
    );
  }

  _buildBody(){
    return BlocBuilder<RemoteReportBloc, RemoteReportState>(
        builder: (_,state){
          if(state is RemoteReportStateLoading){
            print('loading');
            return const Center(child: CupertinoActivityIndicator());
          }
          if(state is RemoteReportStateError){
            print('error');
            return const Center(child: Icon(Icons.refresh));
          }
          if(state is RemoteReportStateDone){
            print('done');
            dtList = state.reports!;
            print(dtList.length);
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('No')),
                            DataColumn(label: Text('Tahun')),
                            DataColumn(label: Text('Jumlah')),
                            DataColumn(label: Text('Berat')),
                          ],
                          rows: List.generate(dtList.length, (index) {
                            return DataRow(cells: [
                              DataCell(Text((index + 1).toString())),
                              DataCell(Text(dtList[index].bulan!)),
                              DataCell(Text(dtList[index].jumlah!)),
                              DataCell(Text(dtList[index].berat!))
                            ]);
                          }),
                        ),
                      ),
                    ),
                    Row(
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
                      ],)
                  ],
                ),
              ),
              backgroundColor: Theme.of(context).primaryColorDark,
            );
          }
          return const SizedBox();
        }
    );
  }

  Future<void> exportToPdf(BuildContext context) async {
    final pdf = pw.Document();

    final fontData = await rootBundle.load("assets/fonts/muli/Muli.ttf");
    final ttf = pw.Font.ttf(fontData);

    var dataList = dtList.map((e) => e.toJson()).toList();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.TableHelper.fromTextArray(
            headers: dataList.first.keys.toList(),
            data: dataList.map((item) => item.values.toList()).toList(),
            cellStyle: pw.TextStyle(font: ttf), // Use custom font here
            headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
          );
        },
      ),
    );

    await saveFileToInternalStorage(await pdf.save(), 'stock.pdf');
  }

  Future<void> exportToExcel() async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    var dataList = dtList.map((e) => e.toJson()).toList();

    sheetObject.appendRow(dataList.first.keys.toList()); // Add header
    for (var row in dataList) {
      sheetObject.appendRow(row.values.toList());
    }

    await saveFileToInternalStorage(Uint8List.fromList(excel.save()!), 'stock.xlsx');
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

