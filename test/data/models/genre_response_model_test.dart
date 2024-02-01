import 'dart:convert';

import '../../../core/lib/data/models/episode_model.dart';
import '../../../core/lib/data/models/episode_response.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:movie/data/models/movie_model.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final genreModel  = GenreModel(
      id: 1,
      name: "Genre 1",
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = genreModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "name": "Genre 1",
      };
      expect(result, expectedJsonMap);
    });
  });
}
