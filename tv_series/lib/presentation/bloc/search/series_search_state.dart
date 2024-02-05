import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class SeriesSearchState extends Equatable {
  final UiState<List<TvSeries>> seriesState;
  final String key;

  const SeriesSearchState({
    required this.seriesState,
    required this.key,
  });

  @override
  List<Object?> get props => [
    seriesState,
  ];

  SeriesSearchState copyWith({
    UiState<List<TvSeries>>? seriesState,
    String? key,
  }) {
    return SeriesSearchState(
      seriesState: seriesState ?? this.seriesState,
      key: key ?? this.key,
    );
  }

  factory SeriesSearchState.initial() {
    return const SeriesSearchState(
      seriesState: ErrorUiState("Please fill search bar to search.."),
      key: "",
    );
  }
}