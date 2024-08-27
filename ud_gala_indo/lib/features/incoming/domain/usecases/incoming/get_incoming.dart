import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/core/usecase/usecase.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/incoming_repository.dart';
import 'package:ud_gala_indo/models/report_model.dart';

class GetIncomingUseCase implements UseCase<DataState<List<IncomingEntity>>, void>{
  final IncomingRepository _incomingRepository;

  GetIncomingUseCase(this._incomingRepository);

  @override
  Future<DataState<List<IncomingEntity>>> call({void params}) {
    return _incomingRepository.getIncomingGoods();
  }
}
