import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class SeriesPopularState extends Equatable {
  final UiState<List<TvSeries>> seriesState;

  const SeriesPopularState({
    required this.seriesState,
  });

  @override
  List<Object?> get props => [
    seriesState,
  ];

  SeriesPopularState copyWith({
    UiState<List<TvSeries>>? seriesState,
  }) {
    return SeriesPopularState(
      seriesState: seriesState ?? this.seriesState,
    );
  }

  factory SeriesPopularState.initial() {
    return const SeriesPopularState(
      seriesState: LoadingUiState(),
    );
  }
}