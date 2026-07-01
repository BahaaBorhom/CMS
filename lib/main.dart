import 'package:cms/features/home/presentation/screens/home_screen.dart';
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
      },
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

// api key for google maps
// AIzaSyAAtJ6pmyOlyQ77q36kHpzgPjuz6XcTNPQAIzaSyAAtJ6pmyOlyQ77q36kHpzgPjuz6XcTNPQ