import 'dart:convert';

import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final seriesModel = TvSeriesModel(
    adult: false,
    backdropPath: "/backdrop_path.jpg",
    genreIds: [1, 2],
    id: 1,
    originalName: "Sample original name",
    overview: "Sample description",
    popularity: 99.392,
    posterPath: "/poster_path.jpg",
    firstAirDate: "2015-01-08",
    name: "Sample Name",
    voteAverage: 7.929,
    voteCount: 49,
    originCountry: const [
      "US"
    ],
    originalLanguage: 'en'
  );

  final seriesResponseModel =
      TvSeriesResponse(tvSeries: <TvSeriesModel>[seriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series/now_playing.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, seriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = seriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/backdrop_path.jpg",
            "genre_ids": [
              1,
              2
            ],
            "id": 1,
            "origin_country": [
              "US"
            ],
            "original_language": "en",
            "original_name": "Sample original name",
            "overview": "Sample description",
            "popularity": 99.392,
            "poster_path": "/poster_path.jpg",
            "first_air_date": "2015-01-08",
            "name": "Sample Name",
            "vote_average": 7.929,
            "vote_count": 49
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
