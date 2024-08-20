import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:ud_gala_indo/features/incoming/domain/entities/outgoing.dart';

abstract class RemoteOutgoingState extends Equatable{
  final List<OutgoingEntity> ? outgoings;
  final DioException ? error;

  RemoteOutgoingState({this.outgoings, this.error});

  @override
  List<Object> get props => [outgoings!, error!];
}

class RemoteOutgoingLoading extends RemoteOutgoingState{
  RemoteOutgoingLoading();
}

class RemoteOutgoingDone extends RemoteOutgoingState{
  RemoteOutgoingDone(List<OutgoingEntity> outgoings) : super (outgoings: outgoings);
}

class RemoteOutgoingError extends RemoteOutgoingState{
  RemoteOutgoingError(DioException error) : super(error: error);
}