import 'package:flutter/material.dart';
import 'package:ud_gala_indo/config/theme/app_theme.dart';
import 'package:ud_gala_indo/injection_container.dart';
import 'package:ud_gala_indo/service/auth_guard.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: theme(),
      routes: {
        '/': (context) => AuthGuard(child: const HomePage()),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}




