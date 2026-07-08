// lib/injection_container.dart
import 'package:cms/features/search/inject_search.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  injectSearch();
}