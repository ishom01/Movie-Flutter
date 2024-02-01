import 'dart:convert';

import '../../../core/lib/data/models/episode_model.dart';
import '../../../core/lib/data/models/episode_response.dart';
import 'package:movie/data/models/movie_model.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final seasonModel = SeasonModel(
      airDate: "2006-05-21",
      episodeCount: 2,
      id: 1,
      name: "Season 1",
      overview: "",
      posterPath: "/poster_path1.jpg",
      seasonNumber: 0,
      voteAverage: 0
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = seasonModel.toJson();
      // assert
      final expectedJsonMap = {
        "air_date": "2006-05-21",
        "episode_count": 2,
        "id": 1,
        "name": "Season 1",
        "overview": "",
        "poster_path": "/poster_path1.jpg",
        "season_number": 0,
        "vote_average": 0.0
      };
      expect(result, expectedJsonMap);
    });
  });
}
