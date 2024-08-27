import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/core/usecase/usecase.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/incoming_repository.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/outgoing_repository.dart';
import 'package:ud_gala_indo/models/report_model.dart';

class GetMonthlyOutgoingUseCase implements UseCase<DataState<List<ReportModel>>, void>{
  final OutgoingRepository _outgoingRepository;

  GetMonthlyOutgoingUseCase(this._outgoingRepository);

  @override
  Future<DataState<List<ReportModel>>> call({void params}) {
    return _outgoingRepository.getMonthlyOutgoing();
  }
}

class GetYearlyOutgoingUseCase implements UseCase<DataState<List<ReportModel>>, void>{
  final OutgoingRepository _outgoingRepository;

  GetYearlyOutgoingUseCase(this._outgoingRepository);

  @override
  Future<DataState<List<ReportModel>>> call({void params}) {
    return _outgoingRepository.getYearlyOutgoing();
  }
}
