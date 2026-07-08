import 'package:cms/features/search/presentation/cubit/searchresult_cubit.dart';

import '../../injection_container.dart';
import 'data/data_sources/remote/search_remote_data_source.dart';
import 'data/repositories/search_repository_impl.dart';
import 'domain/repositories/search_repository.dart';
import 'domain/use_cases/search_use_case.dart';
import 'presentation/cubit/search_cubit.dart';

//call this function in ServiceLocator.setup() function
injectSearch() {
  // cubit
  // getIt.registerFactory(() => SearchCubit(searchUseCase: getIt()));
  getIt.registerFactory<SearchResultsCubit>(() => SearchResultsCubit());
  getIt.registerFactory<SearchCubit>(() => SearchCubit());
  

  // Repository
  getIt.registerLazySingleton<SearchRepository>(
          () => SearchRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => SearchUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<SearchRemoteDataSource>(
          () => SearchRemoteDataSourceImpl());
}
      