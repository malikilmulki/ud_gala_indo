import 'package:equatable/equatable.dart';
import 'package:ud_gala_indo/models/report_model.dart';

abstract class RemoteReportEvent extends Equatable{
  final ReportModel ? reportModel;

  const RemoteReportEvent({this.reportModel});

  @override
  List<Object> get props => [reportModel!];

}


class GetMonthlyIncoming extends RemoteReportEvent{
  GetMonthlyIncoming();
}

class GetYearlyIncoming extends RemoteReportEvent{
  GetYearlyIncoming();
}

class GetMonthlyOutgoing extends RemoteReportEvent{
  GetMonthlyOutgoing();
}

class GetYearlyOutgoing extends RemoteReportEvent{
  GetYearlyOutgoing();
}

class GetStock extends RemoteReportEvent{
  GetStock();
}