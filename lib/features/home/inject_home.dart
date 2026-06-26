import '../../injection_container.dart';
import 'data/data_sources/remote/home_remote_data_source.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/use_cases/home_use_case.dart';
import 'presentation/cubit/home_cubit.dart';

//call this function in ServiceLocator.setup() function
injectHome() {
  // cubit
  getIt.registerFactory(() => HomeCubit(homeUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<HomeRepository>(
          () => HomeRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => HomeUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<HomeRemoteDataSource>(
          () => HomeRemoteDataSourceImpl());
}
      