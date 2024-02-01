import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MovieMainState extends Equatable {
  final UiState<List<Movie>> popularState;
  final UiState<List<Movie>> nowPlayingState;
  final UiState<List<Movie>> topRatedState;

  const MovieMainState({
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

  MovieMainState copyWith({
    UiState<List<Movie>>? popularState,
    UiState<List<Movie>>? nowPlayingState,
    UiState<List<Movie>>? topRatedState,
  }) {
    return MovieMainState(
      popularState: popularState ?? this.popularState,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      topRatedState: topRatedState ?? this.topRatedState,
    );
  }

  factory MovieMainState.initial() {
    return const MovieMainState(
      popularState: LoadingUiState(),
      nowPlayingState: LoadingUiState(),
      topRatedState: LoadingUiState(),
    );
  }
}