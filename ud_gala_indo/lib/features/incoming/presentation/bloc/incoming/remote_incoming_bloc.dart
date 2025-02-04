import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/incoming/delete_incoming.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_event.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_state.dart';

import 'package:ud_gala_indo/features/incoming/domain/usecases/incoming/get_incoming.dart';

class RemoteIncomingBloc extends Bloc<RemoteIncomingEvent, RemoteIncomingState>{
  final GetIncomingUseCase _getIncomingUseCase;
  final DeleteIncomingUseCase _removeIncomingUsecase;

  RemoteIncomingBloc(this._getIncomingUseCase, this._removeIncomingUsecase) : super(const RemoteIncomingLoading()){
    on <GetIncomings>(onGetIncomings);
    on <RemoveIncoming>(onRemoveIncoming);
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

  void onRemoveIncoming(RemoveIncoming removeIncoming, Emitter<RemoteIncomingState> emit) async {
    print('coba hapus');
    await _removeIncomingUsecase(params: removeIncoming.incoming);
    final dataState = await _getIncomingUseCase();
    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      print('bloc success');
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