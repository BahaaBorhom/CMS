// lib/injection_container.dart
import 'package:cms/features/profile/inject_profile.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // ✅ 1. First, initialize SharedPreferences
  // final sharedPreferences = await SharedPreferences.getInstance();
  // getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  injectProfile();
}
