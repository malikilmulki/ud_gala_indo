import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/features/incoming/data/models/incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/incoming/delete_incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/incoming/mothly_incoming.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_event.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_state.dart';

import 'package:ud_gala_indo/features/incoming/domain/usecases/incoming/get_incoming.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/remote_report_event.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/remote_report_state.dart';

class RemoteReportBloc extends Bloc<RemoteReportEvent, RemoteReportState>{
  final GetMonthlyIncomingUseCase _getMonthlyIncomingUseCase;
  final GetYearlyIncomingUseCase _getYearlyIncomingUseCase;

  RemoteReportBloc(this._getMonthlyIncomingUseCase, this._getYearlyIncomingUseCase) : super(RemoteReportStateLoading()){
    on <GetMonthlyIncoming>(onGetMonthlyIncomings);
    on <GetYearlyIncoming>(onGetYearlyIncomings);
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

}