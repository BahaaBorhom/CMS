import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // You can call Cubit methods here if needed, e.g.:
    // context.read<HomeCubit>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state.status == HomeStatus.error) {
            return Scaffold(
              body: Center(
                child: Text(state.errorMessage ?? 'an_error_occurred'),
              ),
            );
          }

          if (state.status == HomeStatus.loaded) {
            // TODO: Replace this with your actual loaded UI
            return const Scaffold(
              body: Center(child: Text('Data Loaded')),
            );
          }

          return Scaffold(
            body: Center(
              child: Text('home screen'),
            ),
          );
        },
      ),
    );
  }
}
