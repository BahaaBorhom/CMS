// lib/injection_container.dart
// import 'package:cms/features/auth/data/data_sources/local/language_data_source.dart';
// import 'package:cms/features/auth/data/repositories/language_repository_imp.dart';
// import 'package:cms/features/auth/domain/use_cases/change_language_use_case.dart';
// import 'package:cms/features/auth/inject_auth.dart';
// import 'package:cms/features/home/inject_home.dart';
import 'package:cms/features/home/inject_home.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cms/features/auth/domain/repositories/language_repository.dart';
// import 'package:cms/features/auth/domain/use_cases/get_saved_language_use_case.dart';
// import 'package:cms/features/auth/presentation/cubit/language_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // ✅ 1. First, initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // ✅ 2. Now register Auth main dependencies (language-related)
  // Data sources - now pass SharedPreferences
  // getIt.registerLazySingleton<LanguageLocalDataSource>(
  //   () => LanguageLocalDataSource(sharedPreferences: getIt()),
  // );

  // Repositories
  // getIt.registerLazySingleton<LanguageRepository>(
  //   () => LanguageRepositoryImpl(localDataSource: getIt()),
  // );

  // Use cases
  // getIt.registerLazySingleton(
  //   () => GetSavedLanguageUseCase(repository: getIt()),
  // );
  // getIt.registerLazySingleton(() => SaveLanguageUseCase(repository: getIt()));

  // Cubit
  // getIt.registerFactory(
  //   () => LanguageCubit(
  //     getSavedLanguageUseCase: getIt(),
  //     saveLanguageUseCase: getIt(),
  //   ),
  // );

  // ✅ 3. Finally, initialize auth-specific injections
  // (LoginCubit, OtpCubit, AuthLocalDataSource, etc.)
  // initAuthInjection();
  injectHome();
}
