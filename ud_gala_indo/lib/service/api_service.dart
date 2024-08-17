import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/login_request.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://sjpapi2.azurewebsites.net/api")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/auths/login")
  Future<HttpResponse> login(@Body() LoginRequest loginRequest);
}
