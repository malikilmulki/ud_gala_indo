import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/outgoing.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/outgoing/remote_outgoing_bloc.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/outgoing/remote_outgoing_event.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/outgoing/remote_outgoing_state.dart';
import 'package:ud_gala_indo/injection_container.dart';

class OutgoingListPage extends StatefulWidget {
  @override
  _OutgoingListPageState createState() => _OutgoingListPageState();
}

class _OutgoingListPageState extends State<OutgoingListPage> {
  OutgoingEntity ? outgoingEntity;
  TextEditingController searchController = TextEditingController();

  void _onDeleteButtonPressed(BuildContext context) {
    print(outgoingEntity);
    var refreshProvider = context.read<RemoteOutgoingBloc>().add(RemoveOutgoing(outgoingEntity!));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        //backgroundColor: Colors.black,
        content: Text('Incoming removed successfully.'),
      ),
    );
  }

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
        child: BlocProvider<RemoteOutgoingBloc>(
          create: (context) => sl()..add(GetOutgoings()),
          child: Scaffold(
              body: _buildBody()
          ),
        )
        );
  }

  _buildBody(){
    return BlocBuilder<RemoteOutgoingBloc, RemoteOutgoingState>(
        builder: (_,state){
          if(state is RemoteOutgoingLoading){
            return const Center(child: CupertinoActivityIndicator());
          }
          if(state is RemoteOutgoingError){
            return const Center(child: Icon(Icons.refresh));
          }
          if(state is RemoteOutgoingDone){
            List<OutgoingEntity>  data = state.outgoings!;
            print(data.length);
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      //width: screenWidth / 3,
                      alignment: Alignment.centerRight,
                      child:
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: 'Search',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          suffixIcon: Icon(Icons.search, size: 20.0),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('No')),
                            DataColumn(label: Text('Nama Karyawan')),
                            DataColumn(label: Text('Tanggal Keluar')),
                            DataColumn(label: Text('Berat Cengkeh')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: List.generate(data.length, (index) {
                            outgoingEntity = data[index];
                            return DataRow(cells: [
                              DataCell(Text(data[index].id!)),
                              DataCell(Text(data[index].karyawan!)),
                              DataCell(Text(data[index].tanggalKeluar!)),
                              DataCell(Text(data[index].beratCengkeh!)),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => _onDeleteButtonPressed(_),
                                    ),
                                  ],
                                ),
                              ),
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
