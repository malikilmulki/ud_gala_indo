
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/incoming.dart';

abstract class RemoteIncomingState extends Equatable{
  final List<IncomingEntity> ? incomings;
  final DioException ? error;

  const RemoteIncomingState({this.incomings, this.error});

  @override
  List<Object> get props => [incomings ?? [], error ?? []];
}

class RemoteIncomingLoading extends RemoteIncomingState{
  const RemoteIncomingLoading();
}

class RemoteIncomingDone extends RemoteIncomingState{
  const RemoteIncomingDone(List<IncomingEntity> incomings) : super (incomings: incomings);
}

class RemoteIncomingError extends RemoteIncomingState{
  const RemoteIncomingError(DioException error) : super(error: error);
}