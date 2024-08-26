import 'package:equatable/equatable.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';

abstract class RemoteIncomingEvent extends Equatable{
  final IncomingEntity ? incoming;

  const RemoteIncomingEvent({this.incoming});

  @override
  List<Object> get props => [incoming!];

  // const RemoteIncomingEvent();
  // Point(this.x, this.y); // Generative constructor
  // Point.origin() : x = 0, y = 0; // Named constructor
}

class GetIncomings extends RemoteIncomingEvent{
  GetIncomings();
}

class SaveIncoming extends RemoteIncomingEvent{
  SaveIncoming(IncomingEntity incomingEntity) : super (incoming: incomingEntity);
}

class RemoveIncoming extends RemoteIncomingEvent{
  RemoveIncoming(IncomingEntity incomingEntity) : super (incoming: incomingEntity);
}