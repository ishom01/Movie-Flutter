import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class SeriesDetailState extends Equatable {
  final UiState<TvSeriesDetail> detailState;
  final UiState<List<TvSeries>> recommendationState;
  final UiState<Map<Season, List<Episode>>> seasonState;
  final String watchlistMessage;
  final bool isAddedFavorite;

  const SeriesDetailState({
    required this.detailState,
    required this.recommendationState,
    required this.seasonState,
    required this.watchlistMessage,
    required this.isAddedFavorite,
  });

  @override
  List<Object?> get props => [
    detailState,
    recommendationState,
    seasonState,
    watchlistMessage,
    isAddedFavorite,
  ];

  SeriesDetailState copyWith({
    UiState<TvSeriesDetail>? detailState,
    UiState<List<TvSeries>>? recommendationState,
    UiState<Map<Season, List<Episode>>>? seasonState,
    String? watchlistMessage,
    bool? isAddedFavorite,
  }) {
    return SeriesDetailState(
      detailState: detailState ?? this.detailState,
      recommendationState: recommendationState ?? this.recommendationState,
      seasonState: seasonState ?? this.seasonState,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedFavorite: isAddedFavorite ?? this.isAddedFavorite,
    );
  }

  factory SeriesDetailState.initial() {
    return const SeriesDetailState(
      detailState: LoadingUiState(),
      recommendationState: LoadingUiState(),
      seasonState: LoadingUiState(),
      watchlistMessage: "",
      isAddedFavorite: false,
    );
  }
}