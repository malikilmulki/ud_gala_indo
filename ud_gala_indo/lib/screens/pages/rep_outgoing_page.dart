import 'dart:io';
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

class ReportOutgoingPage extends StatefulWidget {
  const ReportOutgoingPage({super.key});

  @override
  _ReportOutgoingPageState createState() => _ReportOutgoingPageState();
}

class _ReportOutgoingPageState extends State<ReportOutgoingPage> {
  late List<ReportModel> dtList;

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white),
            color:Theme.of(context).primaryColor
        ),
        child: Center(
          child: BlocProvider<RemoteReportBloc>(
            create: (context) => sl()..add(const GetMonthlyOutgoing()),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('No')),
                            DataColumn(label: Text('Bulan')),
                            DataColumn(label: Text('Jumlah Keluar')),
                            DataColumn(label: Text('Total Berat')),
                          ],
                          rows: List.generate(dtList.length, (index) {
                            return DataRow(cells: [
                              DataCell(Text((index + 1).toString())),
                              DataCell(Text(dtList[index].bulan!)),
                              DataCell(Text(dtList[index].jumlah!)),
                              DataCell(Text("${dtList[index].berat!} kg"))
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
                          child: const Text('Export to PDF'),
                        ),
                        ElevatedButton(
                          onPressed: () => exportToExcel(),
                          child: const Text('Export to Excel'),
                        ),
                      ],)
                  ],
                ),
              ),
              backgroundColor: Theme.of(context).cardColor,
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
    List<String> dataColumns = [ 'Bulan', 'Jumlah Masuk', 'Total Berat'];
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.TableHelper.fromTextArray(
            headers: dataColumns,
            data: dataList.map((item) {
              var valuesList = item.values.toList();
              valuesList[2] = valuesList[2] + ' Kg'; // Change the third column
              return valuesList;
            }).toList(),
            cellStyle: pw.TextStyle(font: ttf), // Use custom font here
            headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
          );
        },
      ),
    );

    await saveFileToInternalStorage(await pdf.save(), 'outgoing.pdf');
  }

  Future<void> exportToExcel() async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    var dataList = dtList.map((e) => e.toJson()).toList();
    List<String> dataColumns = [ 'Bulan', 'Jumlah Masuk', 'Total Berat'];
    sheetObject.appendRow(dataColumns); // Add header
    for (var row in dataList) {
      var valuesList = row.values.toList();
      valuesList[2] = valuesList[2] + ' Kg'; // Change the third column
      sheetObject.appendRow(valuesList);
    }

    await saveFileToInternalStorage(Uint8List.fromList(excel.save()!), 'outgoing.xlsx');
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
