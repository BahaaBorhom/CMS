// lib/features/auth/injection_container.dart
import 'package:get_it/get_it.dart';
import 'data/data_sources/local/auth_local_data_source.dart';
import 'domain/use_cases/check_onboarding_use_case.dart';
import 'domain/use_cases/complete_onboarding_use_case.dart';

final sl = GetIt.instance;

void initAuthInjection() {
  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());
  
  // Use cases
  sl.registerLazySingleton(() => CheckOnboardingUseCase(sl()));
  sl.registerLazySingleton(() => CompleteOnboardingUseCase(sl()));
}