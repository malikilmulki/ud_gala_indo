import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';
import 'package:ud_gala_indo/core/resources/data_state.dart';

abstract class IncomingRepository{
  Future<DataState<List<IncomingEntity>>> getIncomingGoods();
}