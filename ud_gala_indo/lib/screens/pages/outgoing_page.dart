import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutgoingPage extends StatefulWidget {
  @override
  _OutgoingPageState createState() => _OutgoingPageState();
}

class _OutgoingPageState extends State<OutgoingPage> {
  // Sample data for the table
  List<Map<String, String>> data = [
    {
      "No": "1",
      "Nama": "John Doe",
      "Tanggal Masuk": "2024-01-01",
      "Berat": "70kg"
    },
    {
      "No": "2",
      "Nama": "Jane Doe",
      "Tanggal Masuk": "2024-02-01",
      "Berat": "65kg"
    },
  ];

  TextEditingController searchController = TextEditingController();

  void _addNewEntry() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => AddNewEntryPage()),
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
      appBar: AppBar(
        title: Text('Barang Keluar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: screenWidth / 3,
              alignment: Alignment.centerRight,
              child: TextField(
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
                    DataColumn(label: Text('Tanggal Masuk')),
                    DataColumn(label: Text('Berat Cengkeh')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: List.generate(data.length, (index) {
                    return DataRow(cells: [
                      DataCell(Text(data[index]["No"]!)),
                      DataCell(Text(data[index]["Nama"]!)),
                      DataCell(Text(data[index]["Tanggal Masuk"]!)),
                      DataCell(Text(data[index]["Berat"]!)),
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
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.picture_as_pdf),
                  label: Text('PDF Button'),
                  onPressed: () {
                    // Handle button press
                    print('PDF Button Pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Set PDF button color
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: Icon(Icons.print),
                  label: Text('Print Button'),
                  onPressed: () {
                    // Handle button press
                    print('Print Button Pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Set print button color
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
