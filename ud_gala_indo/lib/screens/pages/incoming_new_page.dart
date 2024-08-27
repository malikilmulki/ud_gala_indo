import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:ud_gala_indo/features/incoming/data/data_sources/incoming_api_service.dart';
import 'dart:convert';

import 'package:ud_gala_indo/features/incoming/data/models/incoming.dart';
import 'package:ud_gala_indo/models/barang_model.dart';
import 'package:ud_gala_indo/models/petani_model.dart';
import 'package:ud_gala_indo/service/api_service.dart'; // For JSON parsing
// import 'api_service.dart';

class IncomingNewPage extends StatefulWidget {
  @override
  _IncomingNewPageState createState() => _IncomingNewPageState();
}

class _IncomingNewPageState extends State<IncomingNewPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _kawasanKebunController = TextEditingController();
  final TextEditingController _tanggalMasukController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();

  Dio dio = Dio();
  final apiService = ApiService(Dio());
  final incomingService = IncomingApiService(Dio());
  // late ApiService apiService;

  String? _selectedJenisKelamin;
  List<dynamic> _jenisKelaminOptions = [];

  String? _selectedStatus;
  List<dynamic> _statusOptions = [];

  List<PetaniModel> _listPetani = [];
  List<BarangModel> _listBarang = [];

  PetaniModel? _selectedPetani;
  BarangModel? _selectedBarang;

  @override
  void initState() {
    super.initState();
    _fetchPetani();
    _fetchBarang();
    _loadJenisKelaminData();
    _loadStatusData();
  }

  Future<void> _fetchPetani() async {
    try {
      final data = await apiService.getPetani();
      setState(() {
        _listPetani = data;
      });
    } catch (e) {
      print("Failed to fetch data: $e");
    }
  }

  Future<void> _fetchBarang() async {
    try {
      final data = await apiService.getBarang();
      setState(() {
        _listBarang = data;
      });
    } catch (e) {
      print("Failed to fetch data: $e");
    }
  }

  Future<void> _loadJenisKelaminData() async {
    const String jsonString = '''
    [
      { "id": "L", "label": "Laki-Laki" },
      { "id": "P", "label": "Perempuan" }
    ]
    ''';

    final List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      _jenisKelaminOptions = jsonResponse;
    });
  }

  Future<void> _loadStatusData() async {
    const String jsonString = '''
    [
      { "id": "Basah", "label": "Basah" },
      { "id": "Tidak Basah", "label": "Tidak Basah" }
    ]
    ''';

    final List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      _statusOptions = jsonResponse;
    });
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final newData = IncomingModel(
        barangId: _selectedBarang?.id,
        namaBarang: _selectedBarang?.namaBarang,
        petaniId: _selectedPetani?.id,
        namaPetani: _selectedPetani?.namaPetani,
        jenisKelamin: _selectedJenisKelamin,
        kawasanKebun: _kawasanKebunController.text, // Handle null value
        tanggalMasuk: _tanggalMasukController.text,
        beratCengkeh: _beratController.text,
        status: _selectedStatus,
      );

      try {
        await incomingService.saveData(newData);
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
                              DropdownButtonFormField<BarangModel>(
                                value: _selectedBarang,
                                hint: Text("Select an item"),
                                onChanged: (BarangModel? newValue) {
                                  setState(() {
                                    _selectedBarang = newValue;
                                  });
                                },
                                items: _listBarang.map((BarangModel item) {
                                  return DropdownMenuItem<BarangModel>(
                                    value: item,
                                    child: Text(item.namaBarang!),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Barang",
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              DropdownButtonFormField<PetaniModel>(
                                value: _selectedPetani,
                                hint: Text("Select an item"),
                                onChanged: (PetaniModel? newValue) {
                                  setState(() {
                                    _selectedPetani = newValue;
                                    _selectedJenisKelamin = newValue?.jenisKelamin;
                                    //_textFieldController.text = newValue?.name ?? "";  // Update the TextField with the selected item's name
                                  });
                                },
                                items: _listPetani.map((PetaniModel item) {
                                  return DropdownMenuItem<PetaniModel>(
                                    value: item,
                                    child: Text(item.namaPetani!),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Petani",
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Jenis Kelamin",
                                ),
                                value: _selectedJenisKelamin,
                                items: _jenisKelaminOptions.map((option) {
                                  return DropdownMenuItem<String>(
                                    value: option['id'],
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
                              const SizedBox(height: 16.0),
                              DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Status",
                                ),
                                value: _selectedStatus,
                                items: _statusOptions.map((option) {
                                  return DropdownMenuItem<String>(
                                    value: option['id'],
                                    child: Text(option['label']),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedStatus = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select Status';
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
