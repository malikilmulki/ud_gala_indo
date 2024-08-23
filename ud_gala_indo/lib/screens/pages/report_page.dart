import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ud_gala_indo/screens/pages/rep_incoming_page.dart';
import 'package:ud_gala_indo/screens/pages/rep_outgoing_page.dart';
import 'package:ud_gala_indo/screens/pages/rep_stock_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": ReportIncomingPage(), "title": "Laporan Jumlah Barang Masuk"},
    {"screen": ReportOutgoingPage(), "title": "Laporan Jumlah Barang Keluar"},
    {"screen": ReportStockPage(), "title": "Stock Barang"}
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
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list), label: "Laporan Jumlah Barang Masuk"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list), label: "Laporan Jumlah Barang Keluar"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list), label: "Laporan Stock")
        ],
      ),
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}