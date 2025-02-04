import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_bloc.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_event.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_state.dart';

import '../../injection_container.dart';

class IncomingListPage extends StatefulWidget {
  const IncomingListPage({super.key});

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
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
        color: Theme.of(context).cardColor
      ),
      child: BlocProvider<RemoteIncomingBloc>(
        create: (context) => sl()..add(const GetIncomings()),
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                        suffixIcon: Icon(Icons.search, size: 20.0),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 400, // Fixed height for the scrollable area
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: const [
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
                              DataCell(Text('${data[index].beratCengkeh!} Kg')),
                              DataCell(Text(data[index].status!)),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => _onDeleteButtonPressed(_),
                                    ),
                                  ],
                                ),
                              ),
                            ]);
                          }),
                        ),
                      ),
                    ),
                  ),
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
