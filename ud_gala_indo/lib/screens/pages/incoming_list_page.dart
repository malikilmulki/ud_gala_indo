import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'incoming_new_page.dart';

class IncomingListPage extends StatefulWidget {
  @override
  _IncomingListPageState createState() => _IncomingListPageState();
}

class _IncomingListPageState extends State<IncomingListPage> {
  // Sample data for the table
  List<Map<String, String>> data = [
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
      data.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: screenWidth / 3,
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
                      DataCell(Text(data[index]["No"]!)),
                      DataCell(Text(data[index]["Nama"]!)),
                      DataCell(Text(data[index]["Jenis Kelamin"]!)),
                      DataCell(Text(data[index]["Kawasan Kebun"]!)),
                      DataCell(Text(data[index]["Tanggal Masuk"]!)),
                      DataCell(Text(data[index]["Berat"]!)),
                      DataCell(Text(data[index]["Status"]!)),
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
}
