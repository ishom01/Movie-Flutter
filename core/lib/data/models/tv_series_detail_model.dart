
import 'package:core/data/models/season_model.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_series_detail.dart';
import 'episode_model.dart';
import 'genre_model.dart';

class TvSeriesDetailResponse extends Equatable {
  final bool adult;
  final String? backdropPath;
  final List<int> episodeRunTime;
  final String? firstAirDate;
  final List<GenreModel> genres;
  final String? homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String? lastAirDate;
  final EpisodeModel? lastEpisodeToAir;
  final String name;
  final EpisodeModel? nextEpisodeToAir;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<SeasonModel> seasons;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  TvSeriesDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalLanguage,
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

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) => TvSeriesDetailResponse(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
    firstAirDate: json["first_air_date"],
    genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
    homepage: json["homepage"],
    id: json["id"],
    inProduction: json["in_production"],
    languages: List<String>.from(json["languages"].map((x) => x)),
    lastAirDate: json["last_air_date"],
    lastEpisodeToAir: json["last_episode_to_air"] != null
        ? EpisodeModel.fromJson(json["last_episode_to_air"]) : null,
    name: json["name"],
    nextEpisodeToAir: json["next_episode_to_air"] != null
        ? EpisodeModel.fromJson(json["next_episode_to_air"]) : null,
    numberOfEpisodes: json["number_of_episodes"],
    numberOfSeasons: json["number_of_seasons"],
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    seasons: List<SeasonModel>.from(json["seasons"].map((x) => SeasonModel.fromJson(x))),
    status: json["status"],
    tagline: json["tagline"],
    type: json["type"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
    "first_air_date": firstAirDate,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "in_production": inProduction,
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "last_air_date": lastAirDate,
    "last_episode_to_air": lastEpisodeToAir?.toJson(),
    "name": name,
    "next_episode_to_air": nextEpisodeToAir?.toJson(),
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
    "status": status,
    "tagline": tagline,
    "type": type,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  TvSeriesDetail toEntity() =>
      TvSeriesDetail(
          adult: adult,
          backdropPath: backdropPath,
          firstAirDate: firstAirDate,
          genres: genres.map((x) => x.toEntity()).toList(),
          homepage: homepage,
          id: id,
          languages: languages,
          lastAirDate: lastAirDate,
          lastEpisodeToAir: lastEpisodeToAir?.toEntity(),
          name: name,
          nextEpisodeToAir: nextEpisodeToAir?.toEntity(),
          numberOfEpisodes: numberOfEpisodes,
          numberOfSeasons: numberOfSeasons,
          originalName: originalName,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          seasons: seasons.map((x) => x.toEntity()).toList(),
          status: status,
          tagline: tagline,
          type: type,
          voteAverage: voteAverage,
          voteCount: voteCount
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
    adult,
    backdropPath,
    firstAirDate,
    genres,
    homepage,
    id,
    languages,
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
