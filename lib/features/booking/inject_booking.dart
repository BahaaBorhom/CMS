import '../../injection_container.dart';
import 'data/data_sources/remote/booking_remote_data_source.dart';
import 'data/repositories/booking_repository_impl.dart';
import 'domain/repositories/booking_repository.dart';
import 'domain/use_cases/booking_use_case.dart';
import 'presentation/cubit/booking_cubit.dart';

//call this function in ServiceLocator.setup() function
injectBooking() {
  // cubit
  // getIt.registerFactory(() => BookingCubit(bookingUseCase: getIt()));

  // Repository
  getIt.registerLazySingleton<BookingRepository>(
          () => BookingRepositoryImpl(remoteDataSource: getIt()));

  // UseCases
  getIt.registerLazySingleton(() => BookingUseCase(getIt()));

  // DataSources
  getIt.registerLazySingleton<BookingRemoteDataSource>(
          () => BookingRemoteDataSourceImpl());

  getIt.registerFactory<BookingCubit>(() => BookingCubit());
}
      