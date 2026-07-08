
enum SearchStatus {
  initial,
  loading,
  loaded,
  error,
}

class SearchState {
  final SearchStatus status;
  final String? errorMessage;

  const SearchState({
    required this.status,
    this.errorMessage,
  });

  SearchState copyWith({
    SearchStatus? status,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
