import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ud_gala_indo/screens/pages/outgoing_new_page.dart';

import 'outgoing_new_page.dart';
import 'outgoing_list_page.dart';

class OutgoingPage extends StatefulWidget {
  const OutgoingPage({Key? key}) : super(key: key);

  @override
  State<OutgoingPage> createState() => _OutgoingPageState();
}

class _OutgoingPageState extends State<OutgoingPage> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": OutgoingListPage(), "title": "Daftar Barang Keluar"},
    {"screen": OutgoingNewPage(), "title": "Tambah Barang Keluar"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]["title"]),
      ),
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list), label: 'Daftar Barang Keluar'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.file), label: "Tambah Data")
        ],
      ),
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}