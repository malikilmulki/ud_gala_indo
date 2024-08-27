import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/features/incoming/data/data_sources/incoming_api_service.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/incoming_repository.dart';
import 'package:ud_gala_indo/models/report_model.dart';

import '../models/incoming.dart';

class IncomingRepositoryImpl implements IncomingRepository{
  final IncomingApiService _incomingApiService;


  IncomingRepositoryImpl(this._incomingApiService);

  @override
  Future<DataState<List<IncomingModel>>> getIncomingGoods() async {
    try{
      final httpResponse = await _incomingApiService.getIncomingService();
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
  Future<void> addIncoming(IncomingEntity incomingEntity) async {
    // _incomingApiService.
    print(incomingEntity);
    await _incomingApiService.saveData(IncomingModel.fromEntity(incomingEntity));
  }

  @override
  Future<void> deleteIncoming(IncomingEntity incomingEntity) async {

    try{
      var httpResponse = await _incomingApiService.deleteData(int.parse(incomingEntity.id!));
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

  @override
  Future<DataState<List<ReportModel>>> getMonthlyIncoming() async {
    // TODO: implement getMonthlyIncoming
    try{
      final httpResponse = await _incomingApiService.getMonthlyIncoming();
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
  Future<DataState<List<ReportModel>>> getYearlyIncoming() async {
    // TODO: implement getMonthlyIncoming
    try{
      final httpResponse = await _incomingApiService.getYearlyIncoming();
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