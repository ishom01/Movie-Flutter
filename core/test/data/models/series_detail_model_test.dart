import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeriesModel = TvSeriesDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'releaseDate',
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
    originalLanguage: 'english',
    episodeRunTime: const [1, 2],
    genres: [GenreModel(id: 1, name: "Genre 1")],
    homepage: "homepage",
    inProduction: true,
    languages: const ["in", "en"],
    lastAirDate: "airDate",
    lastEpisodeToAir: null,
    nextEpisodeToAir: null,
    numberOfEpisodes: 2,
    numberOfSeasons: 1,
    seasons: [],
    status: "fixing",
    tagline: "tag line",
    type: "type",
  );

  final series = TvSeriesDetail(
    adult: false,
    backdropPath: 'backdropPath',
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'releaseDate',
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
    genres: [Genre(id: 1, name: "Genre 1")],
    homepage: "homepage",
    languages: ["in", "en"],
    lastAirDate: "airDate",
    lastEpisodeToAir: null,
    nextEpisodeToAir: null,
    numberOfEpisodes: 2,
    numberOfSeasons: 1,
    seasons: [],
    status: "fixing",
    tagline: "tag line",
    type: "type",
  );

  test('should be a subclass of Series entity', () async {
    final result = tSeriesModel.toEntity();
    expect(result, series);
  });
}
