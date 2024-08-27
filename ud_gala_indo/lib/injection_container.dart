import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:ud_gala_indo/features/incoming/data/data_sources/incoming_api_service.dart';
import 'package:ud_gala_indo/features/incoming/data/repository/incoming_repository_impl.dart';
import 'package:ud_gala_indo/features/incoming/data/repository/outgoing_repository_impl.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/incoming_repository.dart';
import 'package:ud_gala_indo/features/incoming/domain/repository/outgoing_repository.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/incoming/delete_incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/incoming/get_incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/incoming/mothly_incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/outgoing/delete_outgoing.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/outgoing/get_outgoing.dart';
import 'package:ud_gala_indo/features/incoming/domain/usecases/outgoing/monthly_outgoing.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/incoming/remote_incoming_bloc.dart';
import 'package:ud_gala_indo/features/incoming/presentation/bloc/remote_report_bloc.dart';

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

  sl.registerSingleton<GetMonthlyIncomingUseCase>(
      GetMonthlyIncomingUseCase(sl())
  );

  sl.registerSingleton<GetYearlyIncomingUseCase>(
      GetYearlyIncomingUseCase(sl())
  );

  sl.registerSingleton<DeleteIncomingUseCase>(
      DeleteIncomingUseCase(sl())
  );

  sl.registerSingleton<GetOutgoingUseCase>(
      GetOutgoingUseCase(sl())
  );

  sl.registerSingleton<GetMonthlyOutgoingUseCase>(
      GetMonthlyOutgoingUseCase(sl())
  );

  sl.registerSingleton<GetYearlyOutgoingUseCase>(
      GetYearlyOutgoingUseCase(sl())
  );

  sl.registerSingleton<DeleteOutgoingUseCase>(
      DeleteOutgoingUseCase(sl())
  );

  sl.registerFactory<RemoteIncomingBloc>(
          ()=> RemoteIncomingBloc(sl(), sl())
  );

  sl.registerFactory<RemoteOutgoingBloc>(
          ()=> RemoteOutgoingBloc(sl(), sl())
  );

  sl.registerFactory<RemoteReportBloc>(
          ()=> RemoteReportBloc(sl(), sl(), sl(), sl())
  );
}