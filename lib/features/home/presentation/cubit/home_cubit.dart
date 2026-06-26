import '../../domain/use_cases/home_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase homeUseCase;

  HomeCubit({required this.homeUseCase})
      : super(const HomeState(status: HomeStatus.initial));

  Future<void> fetchData() async {
    emit(state.copyWith(status: HomeStatus.loading));

    final result = await homeUseCase.call();

    result.fold(
      (exception) => emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: exception.toString(),
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: HomeStatus.loaded,
          errorMessage: null,
        ),
      ),
    );
  }
}
