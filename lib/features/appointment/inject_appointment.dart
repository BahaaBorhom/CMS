import '../../injection_container.dart';
import 'data/data_sources/remote/appointment_remote_data_source.dart';
import 'data/repositories/appointment_repository_impl.dart';
import 'domain/repositories/appointment_repository.dart';
import 'domain/use_cases/appointment_use_case.dart';
import 'presentation/cubit/appointment_cubit.dart';

//call this function in ServiceLocator.setup() function
injectAppointment() {
  // cubit
  getIt.registerFactory(() => AppointmentCubit(appointmentUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<AppointmentRepository>(
          () => AppointmentRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => AppointmentUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<AppointmentRemoteDataSource>(
          () => AppointmentRemoteDataSourceImpl());
}
      