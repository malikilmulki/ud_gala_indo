import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:ud_gala_indo/features/incoming/data/data_sources/incoming_api_service.dart';
import 'package:ud_gala_indo/features/incoming/data/repository/incoming_repositort_impl.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/incoming_repository.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/get_incoming.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<IncomingApiService>(IncomingApiService(sl()));
  
  sl.registerSingleton<IncomingRepository>(
    IncomingRepositoryImpl(sl())
  );

  sl.registerSingleton<GetIncomingUseCase>(
      GetIncomingUseCase(sl())
  );

  sl.registerFactory<RemoteIncomingBloc>(
          ()=> RemoteIncomingBloc(sl())
  );
}