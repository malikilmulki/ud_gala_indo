import 'package:equatable/equatable.dart';
import 'package:ud_gala_indo/models/report_model.dart';

abstract class RemoteReportEvent extends Equatable{
  final ReportModel ? reportModel;

  const RemoteReportEvent({this.reportModel});

  @override
  List<Object> get props => [reportModel!];

}

class GetDailyIncoming extends RemoteReportEvent{
  const GetDailyIncoming();
}

class GetWeeklyIncoming extends RemoteReportEvent{
  const GetWeeklyIncoming();
}

class GetMonthlyIncoming extends RemoteReportEvent{
  const GetMonthlyIncoming();
}

class GetYearlyIncoming extends RemoteReportEvent{
  const GetYearlyIncoming();
}

class GetMonthlyOutgoing extends RemoteReportEvent{
  const GetMonthlyOutgoing();
}

class GetYearlyOutgoing extends RemoteReportEvent{
  const GetYearlyOutgoing();
}

class GetStock extends RemoteReportEvent{
  const GetStock();
}