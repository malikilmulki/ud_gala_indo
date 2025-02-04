import 'package:ud_gala_indo/core/usecase/usecase.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/incoming_repository.dart';

class DeleteIncomingUseCase implements UseCase<void, IncomingEntity>{
  final IncomingRepository _incomingRepository;

  DeleteIncomingUseCase(this._incomingRepository);

  @override
  Future<void> call({IncomingEntity ? params}) {
    return _incomingRepository.deleteIncoming(params!);
  }
}