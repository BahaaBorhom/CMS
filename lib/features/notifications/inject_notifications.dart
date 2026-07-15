// import '../../injection_container.dart';
// import 'data/data_sources/remote/notifications_remote_data_source.dart';
// import 'data/repositories/notifications_repository_impl.dart';
// import 'domain/repositories/notifications_repository.dart';
// import 'domain/use_cases/notifications_use_case.dart';
// import 'presentation/cubit/notifications_cubit.dart';

//call this function in ServiceLocator.setup() function
import 'package:cms/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:cms/injection_container.dart';

injectNotifications() {
  // cubit
  getIt.registerFactory<NotificationsCubit>(() => NotificationsCubit());
}
      