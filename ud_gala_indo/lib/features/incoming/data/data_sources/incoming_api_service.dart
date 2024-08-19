import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ud_gala_indo/core/constants/constansts.dart';
import 'package:ud_gala_indo/features/incoming/data/models/incoming.dart';

part 'incoming_api_service.g.dart';

@RestApi(baseUrl: sjpApiBaseUrl)
abstract class IncomingApiService{
  factory IncomingApiService(Dio dio) = _IncomingApiService;

  @GET('/incoming/getallincominggoods')
  Future<HttpResponse<List<IncomingModel>>> getIncomingService();
}