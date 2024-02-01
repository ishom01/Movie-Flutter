import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class SeriesTopRatedState extends Equatable {
  final UiState<List<TvSeries>> seriesState;

  const SeriesTopRatedState({
    required this.seriesState,
  });

  @override
  List<Object?> get props => [
    seriesState,
  ];

  SeriesTopRatedState copyWith({
    UiState<List<TvSeries>>? seriesState,
  }) {
    return SeriesTopRatedState(
      seriesState: seriesState ?? this.seriesState,
    );
  }

  factory SeriesTopRatedState.initial() {
    return const SeriesTopRatedState(
      seriesState: LoadingUiState(),
    );
  }
}