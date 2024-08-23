import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white),
            color: Theme.of(context).primaryColor
        ),
        child: Scaffold(

            body: Center(
              child: Text(
                'Selamat Datang',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),

            ), backgroundColor: Theme.of(context).primaryColorDark,
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}