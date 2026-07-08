import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    // You can call Cubit methods here if needed, e.g.:
    // context.read<SearchCubit>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchCubit>(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state.status == SearchStatus.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state.status == SearchStatus.error) {
            return Scaffold(
              body: Center(
                child: Text(state.errorMessage ?? 'an_error_occurred'),
              ),
            );
          }

          if (state.status == SearchStatus.loaded) {
            // TODO: Replace this with your actual loaded UI
            return const Scaffold(
              body: Center(child: Text('Data Loaded')),
            );
          }

          return Scaffold(
            body: Center(
              child: Text('search screen'),
            ),
          );
        },
      ),
    );
  }
}
