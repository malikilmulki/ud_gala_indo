import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/features/incoming/data/data_sources/outgoing_api_service.dart';
import 'package:ud_gala_indo/features/incoming/data/models/incoming.dart';
import 'package:ud_gala_indo/features/incoming/data/models/outgoing.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/outgoing.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/incoming_repository.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/outgoing_repository.dart';
import 'package:ud_gala_indo/models/report_model.dart';

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

  @override
  Future<DataState<List<ReportModel>>> getMonthlyOutgoing() async {
    // TODO: implement getMonthlyIncoming
    try{
      final httpResponse = await _outgoingApiService.getMonthlyOutgoing();
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

  @override
  Future<DataState<List<ReportModel>>> getYearlyOutgoing() async {
    // TODO: implement getMonthlyIncoming
    try{
      final httpResponse = await _outgoingApiService.getYearlyOutgoing();
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

  @override
  Future<void> deleteOutgoing(OutgoingEntity entity) async {

    try{
      var httpResponse = await _outgoingApiService.deleteData(int.parse(entity.id!));
      if(httpResponse.response.statusCode == HttpStatus.ok){
        print('success delete');
      }
      else{
        print('failed to delete');
      }
    } on DioException catch(e){
      print(e);
      // return DataFailed(e);
    }
  }
}