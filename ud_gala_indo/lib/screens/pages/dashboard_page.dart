import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Stack(
        children: [
          // Background image layer
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/apple.jpg'), // Make sure this path is correct
                fit: BoxFit.fill, // Adjusts the image to cover the entire background
              ),
            ),
          ),

          // Foreground content layer
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
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
