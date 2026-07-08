import '../../domain/use_cases/search_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase searchUseCase;

  SearchCubit({required this.searchUseCase})
      : super(const SearchState(status: SearchStatus.initial));

  Future<void> fetchData() async {
    emit(state.copyWith(status: SearchStatus.loading));

    final result = await searchUseCase.call();

    result.fold(
      (exception) => emit(
        state.copyWith(
          status: SearchStatus.error,
          errorMessage: exception.toString(),
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: SearchStatus.loaded,
          errorMessage: null,
        ),
      ),
    );
  }
}
