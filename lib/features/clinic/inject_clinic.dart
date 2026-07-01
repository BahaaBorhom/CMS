import '../../injection_container.dart';
import 'data/data_sources/remote/clinic_remote_data_source.dart';
import 'data/repositories/clinic_repository_impl.dart';
import 'domain/repositories/clinic_repository.dart';
import 'domain/use_cases/clinic_use_case.dart';
import 'presentation/cubit/clinic_cubit.dart';

//call this function in ServiceLocator.setup() function
injectClinic() {
  // cubit
  getIt.registerFactory(() => ClinicCubit(clinicUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<ClinicRepository>(
          () => ClinicRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => ClinicUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<ClinicRemoteDataSource>(
          () => ClinicRemoteDataSourceImpl());
}
      