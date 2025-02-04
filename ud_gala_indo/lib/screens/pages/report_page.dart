import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ud_gala_indo/screens/pages/rep_daily_page.dart';
import 'package:ud_gala_indo/screens/pages/rep_incoming_page.dart';
import 'package:ud_gala_indo/screens/pages/rep_outgoing_page.dart';
import 'package:ud_gala_indo/screens/pages/rep_stock_page.dart';
import 'package:ud_gala_indo/screens/pages/rep_weekly_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": const ReportIncomingPage(), "title": "Laporan Jumlah Barang Masuk"},
    {"screen": const ReportOutgoingPage(), "title": "Laporan Jumlah Barang Keluar"},
    {"screen": const ReportStockPage(), "title": "Stock Barang"},
    {"screen": const ReportDailyPage(), "title": "Daily Report"},
    {"screen": const ReportWeeklyPage(), "title": "Weekly Report"}
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
        backgroundColor: Colors.white, // Or your background color
        selectedItemColor: Colors.black, // Or any color you want for selected items
        unselectedItemColor: Colors.grey, // Or any color you want for unselected items
        items: const [
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list), label: "Laporan Barang Masuk"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list), label: "Laporan Barang Keluar"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list), label: "Laporan Stock"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list), label: "Laporan Harian"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list), label: "Laporan Mingguan")
        ],
      ),
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}