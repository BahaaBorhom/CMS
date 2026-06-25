import 'package:cms/features/home/presentation/cubit/home_cubit.dart';

import '../../injection_container.dart';
import 'data/data_sources/remote/home_remote_data_source.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/use_cases/home_use_case.dart';

//call this function in ServiceLocator.setup() function
final sl = getIt ;
injectHome() {
  // cubit
  // getIt.registerFactory(() => HomeCubit(homeUseCase: getIt()));
  sl.registerFactory(() => HomeCubit());

  // Repository
  sl.registerLazySingleton<HomeRepository>(
          () => HomeRepositoryImpl(remoteDataSource: sl()));

  // UseCases
  sl.registerLazySingleton(() => HomeUseCase(sl()));

  // DataSources
  sl.registerLazySingleton<HomeRemoteDataSource>(
          () => HomeRemoteDataSourceImpl());
}
      