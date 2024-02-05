import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MovieTopRatedState extends Equatable {
  final UiState<List<Movie>> movieState;

  const MovieTopRatedState({
    required this.movieState,
  });

  @override
  List<Object?> get props => [
    movieState,
  ];

  MovieTopRatedState copyWith({
    UiState<List<Movie>>? movieState,
  }) {
    return MovieTopRatedState(
      movieState: movieState ?? this.movieState,
    );
  }

  factory MovieTopRatedState.initial() {
    return const MovieTopRatedState(
      movieState: LoadingUiState(),
    );
  }
}