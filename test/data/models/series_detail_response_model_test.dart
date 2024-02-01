import 'dart:convert';

import '../../../core/lib/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final seriesModel = TvSeriesDetailResponse(
    adult: false,
    backdropPath: '/path.jpg',
    id: 1,
    episodeRunTime: [22],
    firstAirDate: "1999-01-31",
    genres: [GenreModel(id: 1, name: "Animation"), GenreModel(id: 2, name: "Comedy")],
    homepage: "google.com",
    inProduction: true,
    languages: ["en"],
    lastAirDate: "2023-12-17",
    lastEpisodeToAir: EpisodeModel(
      id: 1,
      name: "Episode 1",
      overview: "Description",
      voteAverage: 7.0,
      voteCount: 1,
      airDate: "2023-12-17",
      episodeNumber: 1,
      episodeType: "mid_season",
      productionCode: "NACX07",
      runtime: 22,
      seasonNumber: 1,
      showId: 1,
      stillPath: "/path_1.jpg",
    ),
    name: "Sample Series",
    nextEpisodeToAir: EpisodeModel(
      id: 2,
      name: "Episode 2",
      overview: "Sample Description",
      voteAverage: 0,
      voteCount: 0,
      airDate: "2024-03-06",
      episodeNumber: 1,
      episodeType: "standard",
      productionCode: "NACX06",
      runtime: 22,
      seasonNumber: 2,
      showId: 2,
      stillPath: null
    ),
    originalLanguage: "en",
    originalName: "Sample original name",
    overview: "Sample Overview",
    popularity: 1390.723,
    posterPath: "/path.jpg",
    seasons: [
      SeasonModel(
          airDate: "2006-05-21",
          episodeCount: 2,
          id: 1,
          name: "Season 1",
          overview: "",
          posterPath: "/poster_path1.jpg",
          seasonNumber: 0,
          voteAverage: 0
      ),
      SeasonModel(
          airDate: "2006-06-21",
          episodeCount: 2,
          id: 2,
          name: "Season 2",
          overview: "",
          posterPath: "/poster_path2.jpg",
          seasonNumber: 0,
          voteAverage: 0
      )
    ],
    status: "Returning Series",
    tagline: "Parental Discretion Advised, that's how you know it's good.",
    type: "Scripted",
    voteAverage: 7.3,
    voteCount: 4015,
    numberOfSeasons: 2,
    numberOfEpisodes: 10,
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series/detail.json'));
      // act
      final result = TvSeriesDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, seriesModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = seriesModel.toJson();
      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "/path.jpg",
        "episode_run_time": [
          22
        ],
        "first_air_date": "1999-01-31",
        "genres": [
          {
            "id": 1,
            "name": "Animation"
          },
          {
            "id": 2,
            "name": "Comedy"
          }
        ],
        "homepage": "google.com",
        "id": 1,
        "in_production": true,
        "languages": [
          "en"
        ],
        "last_air_date": "2023-12-17",
        "last_episode_to_air": {
          "id": 1,
          "name": "Episode 1",
          "overview": "Description",
          "vote_average": 7.0,
          "vote_count": 1,
          "air_date": "2023-12-17",
          "episode_number": 1,
          "episode_type": "mid_season",
          "production_code": "NACX07",
          "runtime": 22,
          "season_number": 1,
          "show_id": 1,
          "still_path": "/path_1.jpg"
        },
        "name": "Sample Series",
        "next_episode_to_air": {
          "id": 2,
          "name": "Episode 2",
          "overview": "Sample Description",
          "vote_average": 0.0,
          "vote_count": 0,
          "air_date": "2024-03-06",
          "episode_number": 1,
          "episode_type": "standard",
          "production_code": "NACX06",
          "runtime": 22,
          "season_number": 2,
          "show_id": 2,
          "still_path": null
        },
        "number_of_episodes": 10,
        "number_of_seasons": 2,
        "original_language": "en",
        "original_name": "Sample original name",
        "overview": "Sample Overview",
        "popularity": 1390.723,
        "poster_path": "/path.jpg",
        "seasons": [
          {
            "air_date": "2006-05-21",
            "episode_count": 2,
            "id": 1,
            "name": "Season 1",
            "overview": "",
            "poster_path": "/poster_path1.jpg",
            "season_number": 0,
            "vote_average": 0.0
          },
          {
            "air_date": "2006-06-21",
            "episode_count": 2,
            "id": 2,
            "name": "Season 2",
            "overview": "",
            "poster_path": "/poster_path2.jpg",
            "season_number": 0,
            "vote_average": 0.0
          }
        ],
        "status": "Returning Series",
        "tagline": "Parental Discretion Advised, that's how you know it's good.",
        "type": "Scripted",
        "vote_average": 7.3,
        "vote_count": 4015
      };
      expect(result, expectedJsonMap);
    });
  });
}
