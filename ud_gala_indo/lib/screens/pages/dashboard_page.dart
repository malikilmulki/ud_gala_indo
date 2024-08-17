import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Text(
          'Selamat Datang',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      )
    );
  }
}