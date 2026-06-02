import '../../injection_container.dart';
import 'data/data_sources/remote/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/use_cases/auth_use_case.dart';
import 'presentation/cubit/auth_cubit.dart';

//call this function in ServiceLocator.setup() function
injectAuth() {
  // cubit
  getIt.registerFactory(() => AuthCubit(authUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => AuthUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl());
}
      