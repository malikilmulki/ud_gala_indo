import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/core/usecase/usecase.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/incoming_repository.dart';
import 'package:ud_gala_indo/models/report_model.dart';

class GetMonthlyIncomingUseCase implements UseCase<DataState<List<ReportModel>>, void>{
  final IncomingRepository _incomingRepository;

  GetMonthlyIncomingUseCase(this._incomingRepository);

  @override
  Future<DataState<List<ReportModel>>> call({void params}) {
    return _incomingRepository.getMonthlyIncoming();
  }
}

class GetYearlyIncomingUseCase implements UseCase<DataState<List<ReportModel>>, void>{
  final IncomingRepository _incomingRepository;

  GetYearlyIncomingUseCase(this._incomingRepository);

  @override
  Future<DataState<List<ReportModel>>> call({void params}) {
    return _incomingRepository.getYearlyIncoming();
  }
}

class GetStockUseCase implements UseCase<DataState<List<ReportModel>>, void>{
  final IncomingRepository _incomingRepository;

  GetStockUseCase(this._incomingRepository);

  @override
  Future<DataState<List<ReportModel>>> call({void params}) {
    return _incomingRepository.getStock();
  }
}
