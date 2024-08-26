import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:ud_gala_indo/features/incoming/data/data_sources/outgoing_api_service.dart';

import 'package:ud_gala_indo/features/incoming/data/models/outgoing.dart';
import 'package:ud_gala_indo/service/api_service.dart'; // For JSON parsing

class OutgoingNewPage extends StatefulWidget {
  @override
  _OutgoingNewPageState createState() => _OutgoingNewPageState();
}

class _OutgoingNewPageState extends State<OutgoingNewPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _karyawanController = TextEditingController();
  final TextEditingController _tanggalKeluarController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();

  Dio dio = Dio();
  final apiService = ApiService(Dio());
  final outgoingService = OutgoingApiService(Dio());

  @override
  void initState() {
    super.initState();
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final newData = OutgoingModel(
        barangId: '1',
        namaBarang: 'Cengkeh',
        id: '',
        karyawan: _karyawanController.text,
        tanggalKeluar: _tanggalKeluarController.text,
        beratCengkeh: _beratController.text
      );


      try {
        print(newData);
        await outgoingService.saveData(newData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data successfully saved!')),
        );
      } catch (e) {
        print(newData);
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white),
            color: Theme.of(context).primaryColor
        ),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(  // Ensures the entire content can be scrolled
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _karyawanController,
                                decoration: InputDecoration(labelText: 'Karyawan'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter nama karyawan';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _beratController,
                                decoration: InputDecoration(labelText: 'Berat (kg)'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Berat';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _tanggalKeluarController,
                                decoration: InputDecoration(
                                  labelText: 'Tanggal Keluar',
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null) {
                                        setState(() {
                                          _tanggalKeluarController.text =
                                              DateFormat('dd-MM-yyyy').format(pickedDate);
                                        });
                                      }
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Tanggal Masuk';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _saveData,
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
