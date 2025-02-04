import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/incoming/mothly_incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/outgoing/monthly_outgoing.dart';

import 'package:ud_gala_indo/features/incoming/presentation/bloc/remote_report_event.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/remote_report_state.dart';

class RemoteReportBloc extends Bloc<RemoteReportEvent, RemoteReportState>{
  final GetDailyIncomingUseCase _getDailyIncomingUseCase;
  final GetWeeklyIncomingUseCase _getWeeklyIncomingUseCase;
  final GetMonthlyIncomingUseCase _getMonthlyIncomingUseCase;
  final GetYearlyIncomingUseCase _getYearlyIncomingUseCase;
  final GetMonthlyOutgoingUseCase _getMonthlyOutgoingUseCase;
  final GetYearlyOutgoingUseCase _getYearlyOutgoingUseCase;
  final GetStockUseCase _getStockUseCase;

  RemoteReportBloc(
      this._getDailyIncomingUseCase,
      this._getWeeklyIncomingUseCase,
      this._getMonthlyIncomingUseCase,
      this._getYearlyIncomingUseCase,
      this._getMonthlyOutgoingUseCase,
      this._getYearlyOutgoingUseCase,
      this._getStockUseCase
      ) : super(const RemoteReportStateLoading()){
    on <GetDailyIncoming>(onGetDailyIncomings);
    on <GetWeeklyIncoming>(onGetWeeklyIncomings);
    on <GetMonthlyIncoming>(onGetMonthlyIncomings);
    on <GetYearlyIncoming>(onGetYearlyIncomings);
    on <GetMonthlyOutgoing>(onGetMonthlyOutgoings);
    on <GetYearlyOutgoing>(onGetYearlyOutgoings);
    on <GetStock>(onGetStock);
  }

  void onGetDailyIncomings(GetDailyIncoming event, Emitter<RemoteReportState> emit) async{
    final dataState = await _getDailyIncomingUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
          RemoteReportStateDone(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      print(dataState.error!.message);
      emit(
          RemoteReportStateError(dataState.error!)
      );
    }
  }

  void onGetWeeklyIncomings(GetWeeklyIncoming event, Emitter<RemoteReportState> emit) async{
    final dataState = await _getWeeklyIncomingUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
          RemoteReportStateDone(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      print(dataState.error!.message);
      emit(
          RemoteReportStateError(dataState.error!)
      );
    }
  }

  void onGetMonthlyIncomings(GetMonthlyIncoming event, Emitter<RemoteReportState> emit) async{
    final dataState = await _getMonthlyIncomingUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
          RemoteReportStateDone(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      print(dataState.error!.message);
      emit(
          RemoteReportStateError(dataState.error!)
      );
    }
  }

  void onGetMonthlyOutgoings(GetMonthlyOutgoing event, Emitter<RemoteReportState> emit) async{
    final dataState = await _getMonthlyOutgoingUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
          RemoteReportStateDone(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      print(dataState.error!.message);
      emit(
          RemoteReportStateError(dataState.error!)
      );
    }
  }

  void onGetYearlyIncomings(GetYearlyIncoming event, Emitter<RemoteReportState> emit) async{
    final dataState = await _getYearlyIncomingUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
          RemoteReportStateDone(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      print(dataState.error!.message);
      emit(
          RemoteReportStateError(dataState.error!)
      );
    }
  }

  void onGetYearlyOutgoings(GetYearlyOutgoing event, Emitter<RemoteReportState> emit) async{
    final dataState = await _getYearlyOutgoingUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
          RemoteReportStateDone(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      print(dataState.error!.message);
      emit(
          RemoteReportStateError(dataState.error!)
      );
    }
  }

  void onGetStock(GetStock event, Emitter<RemoteReportState> emit) async{
    final dataState = await _getStockUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
          RemoteReportStateDone(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      print(dataState.error!.message);
      emit(
          RemoteReportStateError(dataState.error!)
      );
    }
  }

}