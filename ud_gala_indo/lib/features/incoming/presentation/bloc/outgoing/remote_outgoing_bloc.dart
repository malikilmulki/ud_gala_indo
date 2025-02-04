import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/outgoing/delete_outgoing.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/outgoing/remote_outgoing_event.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/outgoing/remote_outgoing_state.dart';

import 'package:ud_gala_indo/features/incoming/domain/usecases/outgoing/get_outgoing.dart';

class RemoteOutgoingBloc extends Bloc<RemoteOutgoingEvent, RemoteOutgoingState>{
  final GetOutgoingUseCase _getOutgoingUseCase;
  final DeleteOutgoingUseCase _deleteUsecase;

  RemoteOutgoingBloc(this._getOutgoingUseCase, this._deleteUsecase) : super(const RemoteOutgoingLoading()){
    on <GetOutgoings>(onGetOutgoings);
    on <RemoveOutgoing>(onRemoveOutgoing);
  }

  void onGetOutgoings(GetOutgoings event, Emitter<RemoteOutgoingState> emit) async{
    final dataState = await _getOutgoingUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
          RemoteOutgoingDone(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      print(dataState.error!.message);
      emit(
          RemoteOutgoingError(dataState.error!)
      );
    }
  }

  void onRemoveOutgoing(RemoveOutgoing removeIncoming, Emitter<RemoteOutgoingState> emit) async {
    print('coba hapus');
    await _deleteUsecase(params: removeIncoming.outgoing);
    final dataState = await _getOutgoingUseCase();
    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      print('bloc success');
      emit(
          RemoteOutgoingDone(dataState.data!)
      );
    }

    if(dataState is DataFailed){
      print(dataState.error!.message);
      emit(
          RemoteOutgoingError(dataState.error!)
      );
    }
  }
}