import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/genre.dart';

final testTvSeries = TvSeriesModel(
  adult: false,
  backdropPath: 'path.jpg',
  genreIds: [
    1,
    2,
  ],
  id: 1,
  originCountry: [
    "English"
  ],
  originalLanguage: "English",
  originalName: "Sample Name",
  overview: "Description",
  popularity: 120,
  posterPath: "path.jpg",
  firstAirDate: "2012-12-12",
  name: "Sample Name",
  voteCount: 1,
  voteAverage: 5.0
);

final testSeriesList = [testTvSeries];

final tvSeriesGenre1 = Genre(id: 1, name: "Genre 1");

final tvSeriesGenre2 = Genre(id: 2, name: "Genre 2");

final tvSeriesEpisode1 = EpisodeModel(
  airDate: "2012-12-12",
  episodeNumber: 1,
  episodeType: "type",
  id: 1,
  name: "Episode 1",
  overview: "Overview episode 1",
  productionCode: "123",
  runtime: 45,
  seasonNumber: 1,
  showId: 1,
  stillPath: "path.jpg",
  voteAverage: 5.0,
  voteCount: 1
);

final tvSeriesSeason = SeasonModel(
  airDate: "2012-12-12",
  episodeCount: 2,
  id: 1,
  name: "Season 1",
  overview: "Overview season 1",
  posterPath: "path.jpg",
  seasonNumber: 1,
  voteAverage: 10.0
);

final tvSeriesEpisode2 = EpisodeModel(
    airDate: "2012-12-12",
    episodeNumber: 2,
    episodeType: "type",
    id: 1,
    name: "Episode 2",
    overview: "Overview episode 2",
    productionCode: "123",
    runtime: 45,
    seasonNumber: 1,
    showId: 1,
    stillPath: "path.jpg",
    voteAverage: 5.0,
    voteCount: 1
);

final testSeriesDetail = TvSeriesDetailResponse(
  adult: false,
  backdropPath: "path.jpg",
  firstAirDate: "2012-12-12",
  genres: [
    GenreModel(id: 1, name: "Genre 1"),
    GenreModel(id: 2, name: "Genre 2")
  ],
  homepage: "google.com",
  id: 1,
  languages: [
    "English"
  ],
  episodeRunTime: [
    12,
    12
  ],
  inProduction: false,
  originalLanguage: "English",
  lastAirDate: "2012-12-12",
  lastEpisodeToAir: tvSeriesEpisode1,
  name: "Series 1",
  nextEpisodeToAir: tvSeriesEpisode2,
  numberOfEpisodes: 2,
  numberOfSeasons:  1,
  originalName: "Series 1",
  overview: "Overview series",
  popularity: 2.0,
  posterPath: "path.jpg",
  seasons: [
    tvSeriesSeason
  ],
  status: "Status",
  tagline: "Tagline",
  type: "type",
  voteAverage: 2.0,
  voteCount: 1
);
