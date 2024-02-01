import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MovieSearchState extends Equatable {
  final String key;
  final UiState<List<Movie>> movieState;

  const MovieSearchState({
    required this.key,
    required this.movieState,
  });

  @override
  List<Object?> get props => [
    key,
    movieState,
  ];

  MovieSearchState copyWith({
    String? key,
    UiState<List<Movie>>? movieState,
  }) {
    return MovieSearchState(
      key: key ?? this.key,
      movieState: movieState ?? this.movieState,
    );
  }

  factory MovieSearchState.initial() {
    return const MovieSearchState(
      key: "",
      movieState: LoadingUiState(),
    );
  }
}