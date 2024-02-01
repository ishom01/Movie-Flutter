import 'package:core/common/data_state.dart';
import 'package:core/common/home_enum.dart';
import 'package:core/domain/usecase/get_watchlist_status.dart';
import 'package:core/domain/usecase/remove_watchlist.dart';
import 'package:core/domain/usecase/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecase/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/detail/movie_detail_event.dart';
import 'package:movie/presentation/bloc/detail/movie_detail_state.dart';

import '../../../domain/usecase/get_movie_detail.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail detail;
  final GetMovieRecommendations recommendations;
  final GetWatchListStatus watchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;


  MovieDetailBloc(
    this.detail,
    this.recommendations,
    this.watchListStatus,
    this.saveWatchlist,
    this.removeWatchlist
  ): super(MovieDetailState.initial()) {

    on<FetchMovieDetailEvent>((event, emit) async {
      emit(state.copyWith(movieState: const LoadingUiState()));
      final result = await detail.execute(event.id);
      result.fold(
        (failed) => emit(state.copyWith(
            movieState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            movieState: SuccessUiState(success))),
      );
    });

    on<FetchRecommendationMovieDetailEvent>((event, emit) async {
      emit(state.copyWith(recommendationState: const LoadingUiState()));
      final result = await recommendations.execute(event.id);
      result.fold(
        (failed) => emit(state.copyWith(
            recommendationState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            recommendationState: SuccessUiState(success))),
      );
    });

    on<ChangeWatchlistDetailEvent>((event, emit) async {
      if (event.isWatchlist) {
        final result = await saveWatchlist.saveMovie(event.movie);
        result.fold(
          (failed) => emit(state.copyWith(watchlistMessage: failed.message)),
          (success) => emit(state.copyWith(watchlistMessage: success)),
        );
      } else {
        final result = await removeWatchlist.removeMovie(event.movie);
        result.fold(
          (failed) => emit(state.copyWith(watchlistMessage: failed.message)),
          (success) => emit(state.copyWith(watchlistMessage: success)),
        );
      }
      add(LoadWatchlistDetailEvent(event.movie.id));
    });

    on<LoadWatchlistDetailEvent>((event, emit) async {
      final status = await watchListStatus.execute(event.id, DataType.Movie);
      emit(state.copyWith(isAddedFavorite: status));
    });
  }
}