import 'dart:convert';

import 'package:core/data/models/episode_model.dart';
import 'package:core/data/models/episode_response.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final episodeModel = EpisodeModel(
      airDate: "1999-01-31",
      episodeNumber: 1,
      episodeType: "standard",
      id: 66050,
      name: "Episode 1",
      overview: "Description episode 1",
      productionCode: "1ACX01",
      runtime: 22,
      seasonNumber: 1,
      showId: 1434,
      stillPath: "/z9Jd3tN6lclBKhap2xC2Ttq7PPf.jpg",
      voteAverage: 6.94,
      voteCount: 50
  );

  final episodeResponseModel =
      EpisodeResponse(episodes: <EpisodeModel>[episodeModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series/episode_series.json'));
      // act
      final result = EpisodeResponse.fromJson(jsonMap);
      // assert
      expect(result, episodeResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = episodeResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "episodes": [
          {
            "air_date": "1999-01-31",
            "episode_number": 1,
            "episode_type": "standard",
            "id": 66050,
            "name": "Episode 1",
            "overview": "Description episode 1",
            "production_code": "1ACX01",
            "runtime": 22,
            "season_number": 1,
            "show_id": 1434,
            "still_path": "/z9Jd3tN6lclBKhap2xC2Ttq7PPf.jpg",
            "vote_average": 6.94,
            "vote_count": 50
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
