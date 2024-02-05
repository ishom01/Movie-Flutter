import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MoviePopularState extends Equatable {
  final UiState<List<Movie>> movieState;

  const MoviePopularState({
    required this.movieState,
  });

  @override
  List<Object?> get props => [
    movieState,
  ];

  MoviePopularState copyWith({
    UiState<List<Movie>>? movieState,
  }) {
    return MoviePopularState(
      movieState: movieState ?? this.movieState,
    );
  }

  factory MoviePopularState.initial() {
    return const MoviePopularState(
      movieState: LoadingUiState(),
    );
  }
}