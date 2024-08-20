import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:ud_gala_indo/features/incoming/data/models/incoming.dart'; // For JSON parsing
// import 'api_service.dart';

class IncomingNewPage extends StatefulWidget {
  @override
  _IncomingNewPageState createState() => _IncomingNewPageState();
}

class _IncomingNewPageState extends State<IncomingNewPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kawasanKebunController = TextEditingController();
  final TextEditingController _tanggalMasukController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  Dio dio = Dio();
  // late ApiService apiService;

  String? _selectedJenisKelamin;
  List<dynamic> _jenisKelaminOptions = [];

  @override
  void initState() {
    super.initState();
    // apiService = ApiService(dio);
    _loadJenisKelaminData();
  }

  Future<void> _loadJenisKelaminData() async {
    final String jsonString = '''
    [
      { "id": 1, "label": "Male" },
      { "id": 2, "label": "Female" },
      { "id": 3, "label": "Other" }
    ]
    '''; // Replace this with your actual JSON source

    final List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      _jenisKelaminOptions = jsonResponse;
    });
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final newData = IncomingModel(
        namaPetani: _namaController.text,
        jenisKelamin: _selectedJenisKelamin ?? '',
        kawasanKebun: _kawasanKebunController.text.isNotEmpty
            ? _kawasanKebunController.text
            : null, // Handle null value
        tanggalMasuk: _tanggalMasukController.text,
        beratCengkeh: _beratController.text,
        status: _statusController.text,
      );

      try {
        //await apiService.addData(newData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data successfully saved!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _namaController,
                              decoration: InputDecoration(labelText: 'Nama'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Nama';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                              value: _selectedJenisKelamin,
                              items: _jenisKelaminOptions.map((option) {
                                return DropdownMenuItem<String>(
                                  value: option['label'],
                                  child: Text(option['label']),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedJenisKelamin = newValue;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select Jenis Kelamin';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _kawasanKebunController,
                              decoration: InputDecoration(labelText: 'Kawasan Kebun'),
                              validator: (value) {
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _tanggalMasukController,
                              decoration: InputDecoration(
                                labelText: 'Tanggal Masuk',
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
                                        _tanggalMasukController.text =
                                            DateFormat('yyyy-MM-dd').format(pickedDate);
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
                              controller: _statusController,
                              decoration: InputDecoration(labelText: 'Status'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Status';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
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
    );
  }
}
