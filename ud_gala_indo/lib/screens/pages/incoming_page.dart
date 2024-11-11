import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'incoming_list_page.dart';
import 'incoming_new_page.dart';

class IncomingPage extends StatefulWidget {
  const IncomingPage({Key? key}) : super(key: key);

  @override
  State<IncomingPage> createState() => _IncomingPageState();
}

class _IncomingPageState extends State<IncomingPage> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": IncomingListPage(), "title": "Daftar Cengkeh Masuk"},
    {"screen": IncomingNewPage(), "title": "Tambah Cengkeh Masuk"}
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
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list), label: 'Daftar Cengkeh'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.file), label: "Tambah Data")
        ],
      ),
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}