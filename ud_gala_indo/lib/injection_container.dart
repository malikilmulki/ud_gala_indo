import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:ud_gala_indo/features/incoming/data/data_sources/incoming_api_service.dart';
import 'package:ud_gala_indo/features/incoming/data/repository/incoming_repository_impl.dart';
import 'package:ud_gala_indo/features/incoming/data/repository/outgoing_repository_impl.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/incoming_repository.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/outgoing_repository.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/incoming/get_incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/outgoing/get_outgoing.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_bloc.dart';

import 'features/incoming/data/data_sources/outgoing_api_service.dart';
import 'features/incoming/presentation/bloc/outgoing/remote_outgoing_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<IncomingApiService>(IncomingApiService(sl()));
  sl.registerSingleton<OutgoingApiService>(OutgoingApiService(sl()));
  
  sl.registerSingleton<IncomingRepository>(
    IncomingRepositoryImpl(sl())
  );
  sl.registerSingleton<OutgoingRepository>(
      OutgoingRepositoryImpl(sl())
  );

  sl.registerSingleton<GetIncomingUseCase>(
      GetIncomingUseCase(sl())
  );

  sl.registerSingleton<GetOutgoingUseCase>(
      GetOutgoingUseCase(sl())
  );

  sl.registerFactory<RemoteIncomingBloc>(
          ()=> RemoteIncomingBloc(sl())
  );

  sl.registerFactory<RemoteOutgoingBloc>(
          ()=> RemoteOutgoingBloc(sl())
  );
}