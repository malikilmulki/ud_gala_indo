import 'package:ud_gala_indo/core/resources/data_state.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/outgoing.dart';

abstract class OutgoingRepository{
  Future<DataState<List<OutgoingEntity>>> getOutgoingGoods();
}