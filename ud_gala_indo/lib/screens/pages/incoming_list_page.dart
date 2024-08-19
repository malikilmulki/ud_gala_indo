import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_gala_indo/features/incoming/data/models/incoming.dart';
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
  // Sample data for the table
  List<Map<String, String>> data1 = [
    {
      "No": "1",
      "Nama": "John Doe",
      "Jenis Kelamin": "Laki-laki",
      "Kawasan Kebun": "Kebun A",
      "Tanggal Masuk": "2024-01-01",
      "Berat": "70kg",
      "Status": "Aktif"
    },
    {
      "No": "2",
      "Nama": "Jane Doe",
      "Jenis Kelamin": "Perempuan",
      "Kawasan Kebun": "Kebun B",
      "Tanggal Masuk": "2024-02-01",
      "Berat": "65kg",
      "Status": "Non-Aktif"
    },
  ];

  TextEditingController searchController = TextEditingController();

  void _addNewEntry() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => IncomingNewPage()),
    // );
  }

  void _deleteEntry(int index) {
    setState(() {
      data1.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteIncomingBloc>(
      create: (context) => sl()..add(GetIncomings()),
      child: Scaffold(
          body: _buildBody()
      ),
    );

  }
  _buildBody(){
    return BlocBuilder<RemoteIncomingBloc, RemoteIncomingState>(
      builder: (_,state){
        if(state is RemoteIncomingLoading){
          return const Center(child: CupertinoActivityIndicator());
        }
        if(state is RemoteIncomingError){
          return const Center(child: Icon(Icons.refresh));
        }
        if(state is RemoteIncomingDone){
          List<IncomingEntity>  data = state.incomings!;
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
                          DataColumn(label: Text('Nama Petani')),
                          DataColumn(label: Text('Jenis Kelamin')),
                          DataColumn(label: Text('Kawasan Kebun')),
                          DataColumn(label: Text('Tanggal Masuk')),
                          DataColumn(label: Text('Berat Cengkeh')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: List.generate(data.length, (index) {
                          return DataRow(cells: [
                            DataCell(Text(data[index].id!)),
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
                                    onPressed: () => _deleteEntry(index),
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
          );
        }
        return const SizedBox();
      }
    );
  }


  Widget _buildTitleAndDescription(IncomingEntity ? article) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              article!.namaBarang?? '',
              maxLines : 3,
              overflow : TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Butler',
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),

            // Description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  article!.kawasanKebun ?? '',
                  maxLines : 2,
                ),
              ),
            ),

            // Datetime
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  article!.status!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
