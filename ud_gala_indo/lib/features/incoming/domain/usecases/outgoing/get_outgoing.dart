import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/core/usecase/usecase.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/outgoing.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/outgoing_repository.dart';

class GetOutgoingUseCase implements UseCase<DataState<List<OutgoingEntity>>, void>{
  final OutgoingRepository _outgoingRepository;

  GetOutgoingUseCase(this._outgoingRepository);

  @override
  Future<DataState<List<OutgoingEntity>>> call({void params}) {
    return _outgoingRepository.getOutgoingGoods();
  }
}