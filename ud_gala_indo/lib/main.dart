import 'package:flutter/material.dart';
import 'package:ud_gala_indo/service/auth_guard.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => AuthGuard(child: HomePage()),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}




