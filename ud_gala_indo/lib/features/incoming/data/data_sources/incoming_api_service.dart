import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:ud_gala_indo/core/constants/constans.dart';
import 'package:ud_gala_indo/features/incoming/data/models/incoming.dart';
import 'package:ud_gala_indo/models/report_model.dart';
import 'dart:convert';

part 'incoming_api_service.g.dart';

@RestApi(baseUrl: sjpApiBaseUrl)
abstract class IncomingApiService{

  factory IncomingApiService(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        const username = "11213978";
        const password = "60-dayfreetrial";
        final basicAuth =
            'Basic ${base64Encode(utf8.encode('$username:$password'))}';

        options.headers["Authorization"] = basicAuth;
        return handler.next(options);
      },
    ));
    return _IncomingApiService(dio);
  }
  @GET('/incoming/getallincominggoods')
  Future<HttpResponse<List<IncomingModel>>> getIncomingService();

  @GET('/incoming/getdaily')
  Future<HttpResponse<List<ReportModel>>> getDailyIncoming();

  @GET('/incoming/getweekly')
  Future<HttpResponse<List<ReportModel>>> getWeeklyIncoming();

  @GET('/incoming/getmonthly')
  Future<HttpResponse<List<ReportModel>>> getMonthlyIncoming();

  @GET('/incoming/getyearly')
  Future<HttpResponse<List<ReportModel>>> getYearlyIncoming();

  @GET('/report/getstock')
  Future<HttpResponse<List<ReportModel>>> getStock();


  @POST("/incoming/saveincominggoods")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json'
  })
  Future<HttpResponse> saveData(@Body() IncomingModel data);

  @DELETE("/incoming/{id}")
  Future<HttpResponse> deleteData(@Path("id") int id);

}