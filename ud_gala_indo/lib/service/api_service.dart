import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:ud_gala_indo/core/constants/constans.dart';
import 'package:ud_gala_indo/models/barang_model.dart';
import 'package:ud_gala_indo/models/petani_model.dart';
import '../models/login_request.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: sjpApiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/auths/login")
  Future<HttpResponse> login(@Body() LoginRequest loginRequest);

  @GET("/master/getallfarmers")
  Future<List<PetaniModel>> getPetani();

  @GET("/master/getallgoods")
  Future<List<BarangModel>> getBarang();
}
