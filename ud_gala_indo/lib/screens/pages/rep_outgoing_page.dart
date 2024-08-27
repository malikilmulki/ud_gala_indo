import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/outgoing.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/remote_report_bloc.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/remote_report_event.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/remote_report_state.dart';
import 'package:ud_gala_indo/injection_container.dart';
import 'package:ud_gala_indo/models/report_model.dart';

class ReportOutgoingPage extends StatefulWidget {
  @override
  _ReportOutgoingPageState createState() => _ReportOutgoingPageState();
}

class _ReportOutgoingPageState extends State<ReportOutgoingPage> {
  OutgoingEntity ? outgoingEntity;

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
        child: BlocProvider<RemoteReportBloc>(
          create: (context) => sl()..add(GetMonthlyIncoming()),
          child: Scaffold(
              body: _buildBody()
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
            List<ReportModel>  data = state.reports!;
            print(data.length);
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 16.0),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('No')),
                            DataColumn(label: Text('Bulan')),
                            DataColumn(label: Text('Jumlah')),
                            DataColumn(label: Text('Berat')),
                          ],
                          rows: List.generate(data.length, (index) {
                            return DataRow(cells: [
                              DataCell(Text((index + 1).toString())),
                              DataCell(Text(data[index].bulan!)),
                              DataCell(Text(data[index].jumlah!)),
                              DataCell(Text(data[index].berat!))
                            ]);
                          }),
                        ),
                      ),
                    )
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
}
