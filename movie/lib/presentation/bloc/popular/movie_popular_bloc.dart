import 'package:core/common/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecase/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular/movie_popular_event.dart';
import 'package:movie/presentation/bloc/popular/movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {

  final GetPopularMovies popularMovies;

  MoviePopularBloc(
    this.popularMovies,
  ): super(MoviePopularState.initial()) {

    on<MoviePopularEvent>((event, emit) async {
      emit(state.copyWith(movieState: const LoadingUiState()));
      final result = await popularMovies.execute();
      result.fold(
        (failed) => emit(state.copyWith(
            movieState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            movieState: SuccessUiState(success))),
      );
    });
  }
}