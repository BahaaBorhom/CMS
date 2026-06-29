import 'package:cms/core/widgets/splash_screen.dart';
import 'package:cms/features/home/presentation/screens/map_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:cms/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // Initialize dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        MapTestScreen.routeName: (context) => const MapTestScreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}

// api key for google maps
// AIzaSyAAtJ6pmyOlyQ77q36kHpzgPjuz6XcTNPQAIzaSyAAtJ6pmyOlyQ77q36kHpzgPjuz6XcTNPQ