import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/outgoing.dart';
import 'package:ud_gala_indo/models/report_model.dart';

abstract class OutgoingRepository{
  Future<DataState<List<OutgoingEntity>>> getOutgoingGoods();
  Future<DataState<List<ReportModel>>> getMonthlyOutgoing();
  Future<DataState<List<ReportModel>>> getYearlyOutgoing();
  Future<void> deleteOutgoing(OutgoingEntity entity);
}