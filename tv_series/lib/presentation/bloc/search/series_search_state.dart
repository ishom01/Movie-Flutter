import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class SeriesSearchState extends Equatable {
  final UiState<List<TvSeries>> seriesState;

  const SeriesSearchState({
    required this.seriesState,
  });

  @override
  List<Object?> get props => [
    seriesState,
  ];

  SeriesSearchState copyWith({
    UiState<List<TvSeries>>? seriesState,
  }) {
    return SeriesSearchState(
      seriesState: seriesState ?? this.seriesState,
    );
  }

  factory SeriesSearchState.initial() {
    return const SeriesSearchState(
      seriesState: LoadingUiState(),
    );
  }
}