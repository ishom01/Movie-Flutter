import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class SeriesNowPlayingState extends Equatable {
  final UiState<List<TvSeries>> seriesState;

  const SeriesNowPlayingState({
    required this.seriesState,
  });

  @override
  List<Object?> get props => [
    seriesState,
  ];

  SeriesNowPlayingState copyWith({
    UiState<List<TvSeries>>? seriesState,
  }) {
    return SeriesNowPlayingState(
      seriesState: seriesState ?? this.seriesState,
    );
  }

  factory SeriesNowPlayingState.initial() {
    return const SeriesNowPlayingState(
      seriesState: LoadingUiState(),
    );
  }
}