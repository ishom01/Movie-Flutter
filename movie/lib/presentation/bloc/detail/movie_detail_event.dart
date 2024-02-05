import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {

  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchMovieDetailEvent extends MovieDetailEvent {
  final int id;

  const FetchMovieDetailEvent(this.id);

  @override
  List<Object?> get props => [
    id
  ];
}

class FetchRecommendationMovieDetailEvent extends MovieDetailEvent {
  final int id;

  const FetchRecommendationMovieDetailEvent(this.id);

  @override
  List<Object?> get props => [
    id
  ];
}

class ChangeWatchlistDetailEvent extends MovieDetailEvent {
  final bool isWatchlist;
  final MovieDetail movie;

  const ChangeWatchlistDetailEvent(this.isWatchlist, this.movie);

  @override
  List<Object?> get props => [
    isWatchlist
  ];
}

class LoadWatchlistDetailEvent extends MovieDetailEvent {
  final int id;

  const LoadWatchlistDetailEvent(this.id);

  @override
  List<Object?> get props => [];
}