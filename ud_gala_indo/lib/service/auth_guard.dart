import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import 'auth_service.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;
  final AuthService _authService = AuthService();

  AuthGuard({super.key, required this.child});

  Future<bool> _checkAuth() async {
    return await _authService.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data == true) {
          return child;
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
