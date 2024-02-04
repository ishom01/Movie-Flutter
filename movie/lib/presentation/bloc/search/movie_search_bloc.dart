import 'package:core/common/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecase/search_movies.dart';
import 'package:movie/presentation/bloc/search/movie_search_event.dart';
import 'package:movie/presentation/bloc/search/movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {

  final SearchMovies searchMovies;

  MovieSearchBloc(
    this.searchMovies,
  ): super(MovieSearchState.initial()) {

    on<MovieSearchEvent>((event, emit) async {
      emit(state.copyWith(key: event.key, movieState: const LoadingUiState()));
      final result = await searchMovies.execute(event.key);
      result.fold(
        (failed) => emit(state.copyWith(
            movieState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            movieState: SuccessUiState(success))),
      );
    });
  }
}