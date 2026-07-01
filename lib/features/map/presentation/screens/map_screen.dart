import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';

class MapScreen extends StatefulWidget {
  static const routeName = "/map";
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    // You can call Cubit methods here if needed, e.g.:
    // context.read<MapCubit>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MapCubit>(),
      child: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          if (state.status == MapStatus.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state.status == MapStatus.error) {
            return Scaffold(
              body: Center(
                child: Text(state.errorMessage ?? 'an_error_occurred'),
              ),
            );
          }

          if (state.status == MapStatus.loaded) {
            // TODO: Replace this with your actual loaded UI
            return const Scaffold(
              body: Center(child: Text('Data Loaded')),
            );
          }

          return Scaffold(
            body: Center(
              child: Text('map screen'),
            ),
          );
        },
      ),
    );
  }
}
