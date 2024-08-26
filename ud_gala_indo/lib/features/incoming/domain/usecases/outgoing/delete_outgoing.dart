import 'package:ud_gala_indo/core/usecase/usecase.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/outgoing.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/outgoing_repository.dart';

class DeleteOutgoingUseCase implements UseCase<void, OutgoingEntity>{
  final OutgoingRepository _repository;

  DeleteOutgoingUseCase(this._repository);

  @override
  Future<void> call({OutgoingEntity ? params}) {
    return _repository.deleteOutgoing(params!);
  }
}