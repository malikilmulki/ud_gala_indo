import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncomingNewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController kawasanKebunController = TextEditingController();
    final TextEditingController tanggalMasukController = TextEditingController();
    final TextEditingController beratController = TextEditingController();
    final TextEditingController statusController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: namaController,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Jenis Kelamin',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Laki-laki', 'Perempuan']
                          .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                          .toList(),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: kawasanKebunController,
                      decoration: InputDecoration(
                        labelText: 'Kawasan Kebun',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: tanggalMasukController,
                      decoration: InputDecoration(
                        labelText: 'Tanggal Masuk',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: beratController,
                      decoration: InputDecoration(
                        labelText: 'Berat (kg)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: statusController,
                      decoration: InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: FaIcon(FontAwesomeIcons.floppyDisk),
                  label: Text('Save'),
                  onPressed: () {
                    // Handle button press
                    print('PDF Button Pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[300], // Set PDF button color
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
