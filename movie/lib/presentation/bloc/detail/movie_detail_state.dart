import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieDetailState extends Equatable {
  final UiState<MovieDetail> movieState;
  final UiState<List<Movie>> recommendationState;
  final bool isAddedFavorite;

  const MovieDetailState({
    required this.movieState,
    required this.recommendationState,
    required this.isAddedFavorite,
  });

  @override
  List<Object?> get props => [
    movieState,
    recommendationState,
    isAddedFavorite,
  ];

  MovieDetailState copyWith({
    UiState<MovieDetail>? movieState,
    UiState<List<Movie>>? recommendationState,
    bool? isAddedFavorite,
  }) {
    return MovieDetailState(
      movieState: movieState ?? this.movieState,
      recommendationState: recommendationState ?? this.recommendationState,
      isAddedFavorite: isAddedFavorite ?? this.isAddedFavorite,
    );
  }

  factory MovieDetailState.initial() {
    return const MovieDetailState(
      movieState: LoadingUiState(),
      recommendationState: LoadingUiState(),
      isAddedFavorite: false
    );
  }
}