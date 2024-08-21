import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_event.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_state.dart';

import 'package:ud_gala_indo/features/incoming/domain/usecases/incoming/get_incoming.dart';

class RemoteIncomingBloc extends Bloc<RemoteIncomingEvent, RemoteIncomingState>{
  final GetIncomingUseCase _getIncomingUseCase;

  RemoteIncomingBloc(this._getIncomingUseCase) : super(RemoteIncomingLoading()){
    on <GetIncomings>(onGetIncomings);
  }

  void onGetIncomings(GetIncomings event, Emitter<RemoteIncomingState> emit) async{
    final dataState = await _getIncomingUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
        RemoteIncomingDone(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      print(dataState.error!.message);
      emit(
          RemoteIncomingError(dataState.error!)
      );
    }
  }
}