import 'package:core/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

import 'episode.dart';
import 'genre.dart';

class TvSeriesDetail extends Equatable {
  final bool adult;
  final String? backdropPath;
  final String? firstAirDate;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final List<String> languages;
  final String? lastAirDate;
  final Episode? lastEpisodeToAir;
  final String name;
  final Episode? nextEpisodeToAir;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<Season> seasons;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  TvSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    firstAirDate,
    genres,
    homepage,
    id,
    languages,
    lastAirDate,
    lastAirDate,
    lastEpisodeToAir,
    name,
    nextEpisodeToAir,
    numberOfEpisodes,
    numberOfSeasons,
    originalName,
    overview,
    popularity,
    posterPath,
    seasons,
    status,
    tagline,
    type,
    voteAverage,
    voteCount
  ];
}