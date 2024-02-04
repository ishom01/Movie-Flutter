import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

abstract class SeriesDetailEvent extends Equatable {

  const SeriesDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchSeriesDetailEvent extends SeriesDetailEvent {
  final int id;

  const FetchSeriesDetailEvent(this.id);

  @override
  List<Object?> get props => [
    id,
  ];
}

class FetchRecommendationSeriesDetailEvent extends SeriesDetailEvent {
  final int id;

  const FetchRecommendationSeriesDetailEvent(this.id);

  @override
  List<Object?> get props => [
    id,
  ];
}

class FetchEpisodeEvent extends SeriesDetailEvent {
  final int id;

  const FetchEpisodeEvent(this.id);

  @override
  List<Object?> get props => [
    id,
  ];
}

class ChangeWatchlistDetailEvent extends SeriesDetailEvent {
  final bool isWatchlist;
  final TvSeriesDetail detail;

  const ChangeWatchlistDetailEvent(this.isWatchlist, this.detail);

  @override
  List<Object?> get props => [
    isWatchlist,
    detail,
  ];
}

class LoadWatchlistDetailEvent extends SeriesDetailEvent {
  final int id;

  const LoadWatchlistDetailEvent(this.id);

  @override
  List<Object?> get props => [
    id,
  ];
}