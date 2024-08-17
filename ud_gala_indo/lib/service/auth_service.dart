import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ud_gala_indo/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:ud_gala_indo/models/login_request.dart';

class AuthService {
  final String baseUrl = "https://sjpapi2.azurewebsites.net";
  final apiService = ApiService(Dio());

  Future<String?> login(String username, String password) async {

    final loginRequest = LoginRequest(username: username, password: password); // Replace with actual user input
    try {
      final response = await apiService.login(loginRequest);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.data);
      return response.data;
    } catch (error) {
      print("Login failed: $error");
      return null;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
