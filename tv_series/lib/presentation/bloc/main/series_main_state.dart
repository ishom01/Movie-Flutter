import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class SeriesMainState extends Equatable {
  final UiState<List<TvSeries>> popularState;
  final UiState<List<TvSeries>> nowPlayingState;
  final UiState<List<TvSeries>> topRatedState;

  const SeriesMainState({
    required this.popularState,
    required this.nowPlayingState,
    required this.topRatedState,
  });

  @override
  List<Object?> get props => [
    popularState,
    nowPlayingState,
    topRatedState,
  ];

  SeriesMainState copyWith({
    UiState<List<TvSeries>>? popularState,
    UiState<List<TvSeries>>? nowPlayingState,
    UiState<List<TvSeries>>? topRatedState,
  }) {
    return SeriesMainState(
      popularState: popularState ?? this.popularState,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      topRatedState: topRatedState ?? this.topRatedState,
    );
  }

  factory SeriesMainState.initial() {
    return const SeriesMainState(
      popularState: LoadingUiState(),
      nowPlayingState: LoadingUiState(),
      topRatedState: LoadingUiState(),
    );
  }
}