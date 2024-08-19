import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/incoming.dart';

abstract class RemoteIncomingState extends Equatable{
  final List<IncomingEntity> ? incomings;
  final DioException ? error;

  RemoteIncomingState({this.incomings, this.error});

  @override
  List<Object> get props => [incomings!, error!];
}

class RemoteIncomingLoading extends RemoteIncomingState{
  RemoteIncomingLoading();
}

class RemoteIncomingDone extends RemoteIncomingState{
  RemoteIncomingDone(List<IncomingEntity> incomings) : super (incomings: incomings);
}

class RemoteIncomingError extends RemoteIncomingState{
  RemoteIncomingError(DioException error) : super(error: error);
}