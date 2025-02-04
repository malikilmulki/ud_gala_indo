import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  late String token;

  // AuthInterceptor(this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add the Authorization header with the Bearer token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('jwtoken') ?? "";
    print('test');
    options.headers['Authorization'] = 'Bearer $token';
      return super.onRequest(options, handler);
  }
}
