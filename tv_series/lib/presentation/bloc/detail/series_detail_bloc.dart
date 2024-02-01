import 'package:core/common/data_state.dart';
import 'package:core/domain/usecase/get_watchlist_status.dart';
import 'package:core/domain/usecase/remove_watchlist.dart';
import 'package:core/domain/usecase/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecase/get_series_recommendations.dart';
import 'package:tv_series/domain/usecase/get_tv_series_detail.dart';
import 'package:tv_series/presentation/bloc/detail/series_detail_event.dart';
import 'package:tv_series/presentation/bloc/detail/series_detail_state.dart';

class SeriesDetailBloc
    extends Bloc<SeriesDetailEvent, SeriesDetailState> {

  final GetTvSeriesDetail detail;
  final GetSeriesRecommendations recommendations;
  final GetWatchListStatus watchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  SeriesDetailBloc(
    this.detail,
      this.recommendations,
      this.watchListStatus,
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
  }
}