import 'package:core/common/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecase/get_now_playing_movies.dart';
import 'package:movie/domain/usecase/get_popular_movies.dart';
import 'package:movie/domain/usecase/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/main/movie_main_event.dart';
import 'package:movie/presentation/bloc/main/movie_main_state.dart';

class MovieMainBloc extends Bloc<MovieMainEvent, MovieMainState> {

  final GetPopularMovies popularMovies;
  final GetNowPlayingMovies nowPlayingMovies;
  final GetTopRatedMovies topRatedMovies;

  MovieMainBloc(
    this.popularMovies,
    this.nowPlayingMovies,
    this.topRatedMovies,
  ): super(MovieMainState.initial()) {

    on<MovieMainPopularEvent>((event, emit) async {
      emit(state.copyWith(popularState: const LoadingUiState()));
      final result = await popularMovies.execute();
      result.fold(
        (failed) => emit(state.copyWith(
            popularState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            popularState: SuccessUiState(success))),
      );
    });

    on<MovieMainTopRatedEvent>((event, emit) async {
      emit(state.copyWith(topRatedState: const LoadingUiState()));
      final result = await topRatedMovies.execute();
      result.fold(
        (failed) => emit(state.copyWith(
            topRatedState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            topRatedState: SuccessUiState(success))),
      );
    });

    on<MovieMainNowPlayingEvent>((event, emit) async {
      emit(state.copyWith(nowPlayingState: const LoadingUiState()));
      final result = await nowPlayingMovies.execute();
      result.fold(
        (failed) => emit(state.copyWith(
            nowPlayingState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            nowPlayingState: SuccessUiState(success))),
      );
    });
  }
}