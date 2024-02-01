import 'package:core/common/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecase/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/top_rated/movie_top_rated_event.dart';
import 'package:movie/presentation/bloc/top_rated/movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {

  final GetTopRatedMovies topRatedMovies;

  MovieTopRatedBloc(
    this.topRatedMovies,
  ): super(MovieTopRatedState.initial()) {

    on<MovieTopRatedEvent>((event, emit) async {
      emit(state.copyWith(movieState: const LoadingUiState()));
      final result = await topRatedMovies.execute();
      result.fold(
        (failed) => emit(state.copyWith(
            movieState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            movieState: SuccessUiState(success))),
      );
    });
  }
}