import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const routeName = "/welcome";

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(actions: [Icon(Icons.arrow_back)]));
  }
}
