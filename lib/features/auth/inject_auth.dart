// lib/features/auth/injection_container.dart
import 'package:cms/features/auth/presentation/cubit/login_cubit.dart';
import 'package:cms/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:cms/injection_container.dart';
import 'data/data_sources/local/auth_local_data_source.dart';
import 'domain/use_cases/check_onboarding_use_case.dart';
import 'domain/use_cases/complete_onboarding_use_case.dart';

final sl = getIt;

void initAuthInjection() {
  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  // Use cases
  sl.registerLazySingleton(() => CheckOnboardingUseCase(sl()));
  sl.registerLazySingleton(() => CompleteOnboardingUseCase(sl()));

  // Cubits
  sl.registerFactory<LoginCubit>(() => LoginCubit());

  sl.registerFactory<OtpCubit>(() => OtpCubit());
}
