import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState()) {
    _loadPopularSearches();
  }

  void onQueryChanged(String query) {
    emit(state.copyWith(query: query));
  }

  void addRecentSearch(String query) {
    if (query.trim().isEmpty) return;
    final updated = [query, ...state.recentSearches.where((s) => s != query)];
    emit(state.copyWith(
      recentSearches: updated.take(5).toList(),
      query: query,
    ));
  }

  void clearRecentSearches() {
    emit(state.copyWith(recentSearches: []));
  }

  void _loadPopularSearches() {
    // Replace with real data from API later
    emit(state.copyWith(
      popularSearches: [
        'Dr. Folan Al-Folani',
        'Heart clinic',
        'Dentist',
        'Al-Mazzeh Medical Center',
        'Damascus Eye Hospital',
      ],
    ));
  }
}