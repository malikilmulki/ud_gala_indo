import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_bloc.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_event.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_state.dart';

import '../../injection_container.dart';
import 'incoming_new_page.dart';

class IncomingListPage extends StatefulWidget {
  @override
  _IncomingListPageState createState() => _IncomingListPageState();
}

class _IncomingListPageState extends State<IncomingListPage> {
  IncomingEntity ? incoming;
  TextEditingController searchController = TextEditingController();


  void _onDeleteButtonPressed(BuildContext context) {
    print(incoming);
    var refreshProvider = context.read<RemoteIncomingBloc>().add(RemoveIncoming(incoming!));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        //backgroundColor: Colors.black,
        content: Text('Incoming removed successfully.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
        color: Theme.of(context).cardColor
      ),
      child: BlocProvider<RemoteIncomingBloc>(
        create: (context) => sl()..add(GetIncomings()),
        child: Scaffold(
            body: _buildBody()
        ),
      ),
    );


  }
  _buildBody(){
    return BlocBuilder<RemoteIncomingBloc, RemoteIncomingState>(
      builder: (_,state){
        if(state is RemoteIncomingLoading){
          print('loading');
          return const Center(child: Icon(Icons.refresh));
        }
        if(state is RemoteIncomingError){
          print('err');
          print('error$state.error');
          return const Center(child: Icon(Icons.refresh));
        }
        if(state is RemoteIncomingDone){
          print('success');
          List<IncomingEntity>  data = state.incomings!;
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
                          DataColumn(label: Text('Nama Petani')),
                          DataColumn(label: Text('Jenis Kelamin')),
                          DataColumn(label: Text('Kawasan Kebun')),
                          DataColumn(label: Text('Tanggal Masuk')),
                          DataColumn(label: Text('Berat Cengkeh')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: List.generate(data.length, (index) {
                          incoming = data[index];
                          return DataRow(cells: [
                            DataCell(Text(data[index].no!)),
                            DataCell(Text(data[index].namaPetani!)),
                            DataCell(Text(data[index].jenisKelamin!)),
                            DataCell(Text(data[index].kawasanKebun!)),
                            DataCell(Text(data[index].tanggalMasuk!)),
                            DataCell(Text(data[index].beratCengkeh!)),
                            DataCell(Text(data[index].status!)),
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
            backgroundColor: Theme.of(context).cardColor,
          );
        }
        return const SizedBox();
      }
    );
  }
}
