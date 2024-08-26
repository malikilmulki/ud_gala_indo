import 'package:ud_gala_indo/features/incoming/domain/entities/outgoing.dart';

abstract class RemoteOutgoingEvent{
  final OutgoingEntity ? outgoing;

  const RemoteOutgoingEvent({this.outgoing});

  @override
  List<Object> get props => [outgoing!];
}

class GetOutgoings extends RemoteOutgoingEvent{
  GetOutgoings();
}

class SaveOutgoing extends RemoteOutgoingEvent{
  SaveOutgoing(OutgoingEntity entity) : super (outgoing: entity);
}

class RemoveOutgoing extends RemoteOutgoingEvent{
  RemoveOutgoing(OutgoingEntity entity) : super (outgoing: entity);
}