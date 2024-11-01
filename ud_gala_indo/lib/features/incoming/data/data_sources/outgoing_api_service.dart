import 'package:dio/dio.dart'hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:ud_gala_indo/core/constants/constans.dart';
import 'package:ud_gala_indo/features/incoming/data/models/outgoing.dart';
import 'package:ud_gala_indo/models/report_model.dart';

part 'outgoing_api_service.g.dart';

@RestApi(baseUrl: sjpApiBaseUrl)
abstract class OutgoingApiService{
  factory OutgoingApiService(Dio dio) = _OutgoingApiService;

  @GET('/outgoing/getalloutgoinggoods')
  Future<HttpResponse<List<OutgoingModel>>> getOutgoingService();

  @GET('/outgoing/getmonthly')
  Future<HttpResponse<List<ReportModel>>> getMonthlyOutgoing();

  @GET('/outgoing/getyearly')
  Future<HttpResponse<List<ReportModel>>> getYearlyOutgoing();

  @POST("/outgoing/saveoutgoinggoods")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<HttpResponse> saveData(@Body() OutgoingModel data);

  @DELETE("/outgoing/{id}")
  Future<HttpResponse> deleteData(@Path("id") int id);

}