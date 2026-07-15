import '../../injection_container.dart';
import 'data/data_sources/remote/profile_remote_data_source.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/use_cases/profile_use_case.dart';
import 'presentation/cubit/edit_profile_cubit.dart';

//call this function in ServiceLocator.setup() function
injectProfile() {
  // cubit
  // getIt.registerFactory(() => ProfileCubit(profileUseCase: getIt()));
  getIt.registerFactory<EditProfileCubit>(() => EditProfileCubit());
  // Repository
  getIt.registerLazySingleton<ProfileRepository>(
          () => ProfileRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => ProfileUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
          () => ProfileRemoteDataSourceImpl());
}
      