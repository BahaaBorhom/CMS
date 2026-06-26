
enum HomeStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeState {
  final HomeStatus status;
  final String? errorMessage;

  const HomeState({
    required this.status,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
