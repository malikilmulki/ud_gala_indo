import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ud_gala_indo/screens/pages/dashboard_page.dart';
import 'package:ud_gala_indo/screens/pages/incoming_page.dart';
import 'package:ud_gala_indo/screens/pages/outgoing_page.dart';
import 'package:ud_gala_indo/screens/pages/report_page.dart';

import '../service/auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedMenuIndex = 0;

  // List of menu items
  final List<String> _menuItems = [
    'Dashboard',
    'Barang Masuk',
    'Barang Keluar',
    'Laporan',
    'Logout',
  ];

  List<NavigationRailDestination> _buildDestinations() {
    return [
      NavigationRailDestination(
        icon: FaIcon(FontAwesomeIcons.house, color: Colors.lightGreenAccent),
        label: Text('Dashboard'),
      ),
      const NavigationRailDestination(
        icon: FaIcon(FontAwesomeIcons.inbox, color: Colors.lightGreenAccent),
        label: Text('Barang Masuk'),
      ),
      const NavigationRailDestination(
        icon: FaIcon(FontAwesomeIcons.share, color: Colors.lightGreenAccent),
        label: Text('Barang Keluar'),
      ),
      const NavigationRailDestination(
        icon: FaIcon(FontAwesomeIcons.file, color: Colors.lightGreenAccent),
        label: Text('Reports'),
      ),
      const NavigationRailDestination(
        icon: FaIcon(FontAwesomeIcons.arrowRightFromBracket, color: Colors.lightGreenAccent),
        label: Text('Logout'),

      ),
    ];
  }
  // Function to map the selected index to the corresponding page
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return DashboardPage();
      case 1:
        return IncomingPage();
      case 2:
        return OutgoingPage();
      case 3:
        return ReportPage();
      default:
        return DashboardPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text('UD Gala Indo'),
      ),
      body: Row(
        children: <Widget>[
          // Left Sidebar
          NavigationRail(
            selectedIndex: _selectedMenuIndex,
            // backgroundColor: Colors.blue,
            // unselectedLabelTextStyle: TextStyle(color: Colors.white),
            // selectedIconTheme: IconThemeData(color: Colors.yellow),
            onDestinationSelected: (int index) async {
              setState(() {
                _selectedMenuIndex = index;
              });
              if(index == 4){
                await _authService.logout();
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            labelType: NavigationRailLabelType.all,
            destinations: _buildDestinations().toList(),
          ),
          VerticalDivider(thickness: 1, width: 1),
          // Right Content (changing based on selected menu)
          Expanded(
            child: _getPage(_selectedMenuIndex),
          ),
        ],
      ),
    );
  }
}
