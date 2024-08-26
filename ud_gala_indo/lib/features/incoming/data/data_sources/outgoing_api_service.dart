import 'package:dio/dio.dart'hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:ud_gala_indo/core/constants/constansts.dart';
import 'package:ud_gala_indo/features/incoming/data/models/outgoing.dart';

part 'outgoing_api_service.g.dart';

@RestApi(baseUrl: sjpApiBaseUrl)
abstract class OutgoingApiService{
  factory OutgoingApiService(Dio dio) = _OutgoingApiService;

  @GET('/outgoing/getalloutgoinggoods')
  Future<HttpResponse<List<OutgoingModel>>> getOutgoingService();

  @POST("/outgoing/saveoutgoinggoods")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<HttpResponse> saveData(@Body() OutgoingModel data);

  @DELETE("/outgoing/{id}")
  Future<HttpResponse> deleteData(@Path("id") int id);

}