import 'package:core/common/data_state.dart';
import 'package:core/common/home_enum.dart';
import 'package:core/domain/usecase/get_watchlist_status.dart';
import 'package:core/domain/usecase/remove_watchlist.dart';
import 'package:core/domain/usecase/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecase/get_series_episode.dart';
import 'package:tv_series/domain/usecase/get_series_recommendations.dart';
import 'package:tv_series/domain/usecase/get_tv_series_detail.dart';
import 'package:tv_series/presentation/bloc/detail/series_detail_event.dart';
import 'package:tv_series/presentation/bloc/detail/series_detail_state.dart';

class SeriesDetailBloc
    extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail detail;
  final GetSeriesRecommendations recommendations;
  final GetSeriesEpisodes episodes;
  final GetWatchListStatus watchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  SeriesDetailBloc(
    this.detail,
      this.recommendations,
      this.watchListStatus,
      this.episodes,
      this.saveWatchlist,
      this.removeWatchlist,
  ): super(SeriesDetailState.initial()) {

    on<FetchSeriesDetailEvent>((event, emit) async {
      emit(state.copyWith(detailState: const LoadingUiState()));
      final result = await detail.execute(event.id);
      result.fold(
        (failed) => emit(state.copyWith(
            detailState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            detailState: SuccessUiState(success))),
      );

      add(LoadWatchlistDetailEvent(event.id));
    });

    on<FetchRecommendationSeriesDetailEvent>((event, emit) async {
      emit(state.copyWith(recommendationState: const LoadingUiState()));
      final result = await recommendations.execute(event.id);
      result.fold(
        (failed) => emit(state.copyWith(
            recommendationState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            recommendationState: SuccessUiState(success))),
      );
    });

    on<FetchEpisodeEvent>((event, emit) async {
      emit(state.copyWith(seasonState: const LoadingUiState()));
      final result = await episodes.execute(event.id);
      result.fold(
        (failed) => emit(state.copyWith(
          seasonState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            seasonState: SuccessUiState(success))),
      );
    });

    on<ChangeWatchlistDetailEvent>((event, emit) async {
      if (event.isWatchlist) {
        await saveWatchlist.saveSeries(event.detail);
      } else {
        await removeWatchlist.removeSeries(event.detail);
      }
      emit(state.copyWith(isFavorite: event.isWatchlist));
    });

    on<LoadWatchlistDetailEvent>((event, emit) async {
      final status = await watchListStatus.execute(event.id, DataType.TvSeries);
      emit(state.copyWith(isFavorite: status));
    });
  }
}