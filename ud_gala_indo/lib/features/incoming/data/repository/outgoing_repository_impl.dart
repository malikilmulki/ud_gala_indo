import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/features/incoming/data/data_sources/outgoing_api_service.dart';
import 'package:ud_gala_indo/features/incoming/data/models/incoming.dart';
import 'package:ud_gala_indo/features/incoming/data/models/outgoing.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/incoming_repository.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/outgoing_repository.dart';

import '../data_sources/outgoing_api_service.dart';

class OutgoingRepositoryImpl implements OutgoingRepository{
  final OutgoingApiService _outgoingApiService;

  OutgoingRepositoryImpl(this._outgoingApiService);

  @override
  Future<DataState<List<OutgoingModel>>> getOutgoingGoods() async {
    try{
      final httpResponse = await _outgoingApiService.getOutgoingService();
      if(httpResponse.response.statusCode == HttpStatus.ok){
        return DataSuccess(httpResponse.data);
      }
      else{
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                requestOptions: httpResponse.response.requestOptions
            ));
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }
}