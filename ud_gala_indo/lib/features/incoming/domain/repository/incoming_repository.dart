import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';
import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/models/report_model.dart';

abstract class IncomingRepository{
  Future<DataState<List<IncomingEntity>>> getIncomingGoods();
  Future<DataState<List<ReportModel>>> getDailyIncoming();
  Future<DataState<List<ReportModel>>> getWeeklyIncoming();
  Future<DataState<List<ReportModel>>> getMonthlyIncoming();
  Future<DataState<List<ReportModel>>> getYearlyIncoming();
  Future<DataState<List<ReportModel>>> getStock();
  Future<void> addIncoming(IncomingEntity incomingEntity);
  Future<void> deleteIncoming(IncomingEntity incomingEntity);
}