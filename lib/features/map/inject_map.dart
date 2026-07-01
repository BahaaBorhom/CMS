import '../../injection_container.dart';
import 'data/data_sources/remote/map_remote_data_source.dart';
import 'data/repositories/map_repository_impl.dart';
import 'domain/repositories/map_repository.dart';
import 'domain/use_cases/map_use_case.dart';
import 'presentation/cubit/map_cubit.dart';

//call this function in ServiceLocator.setup() function
injectMap() {
  // cubit
  getIt.registerFactory(() => MapCubit(mapUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<MapRepository>(
          () => MapRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => MapUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<MapRemoteDataSource>(
          () => MapRemoteDataSourceImpl());
}
      