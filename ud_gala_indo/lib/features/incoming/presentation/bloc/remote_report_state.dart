
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:ud_gala_indo/models/report_model.dart';

abstract class RemoteReportState extends Equatable{
  final List<ReportModel> ? reports;
  final DioException ? error;

  const RemoteReportState({this.reports, this.error});

  @override
  List<Object> get props => [reports ?? [], error ?? []];
}

class RemoteReportStateLoading extends RemoteReportState{
  const RemoteReportStateLoading();
}

class RemoteReportStateDone extends RemoteReportState{
  const RemoteReportStateDone(List<ReportModel> reports) : super (reports: reports);
}

class RemoteReportStateError extends RemoteReportState{
  const RemoteReportStateError(DioException error) : super(error: error);
}