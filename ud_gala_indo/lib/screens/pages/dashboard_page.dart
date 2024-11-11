import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Stack(
        children: [
          // Background image layer
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/apple.jpg'), // Make sure this path is correct
                fit: BoxFit.fill, // Adjusts the image to cover the entire background
              ),
            ),
          ),

          // Foreground content layer
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.white),
              color: Theme.of(context).primaryColor.withOpacity(0.8), // Slightly transparent
            )
          ),
        ],
      ),
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}
