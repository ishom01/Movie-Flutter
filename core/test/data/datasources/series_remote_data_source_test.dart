import 'dart:convert';

import 'package:core/common/constants.dart';
import 'package:core/common/exception.dart';
import 'package:core/data/models/episode_response.dart';
import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:core/data/sources/tv_series_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });
  
  group('get Now Playing Series', () {
    final tvSeries = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/now_playing.json'))
    ).tvSeries;

    test('should return list of Series Model when the response is 200',
        () async {
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series/now_playing.json'), 200));
          // act
          final result = await dataSource.getNowPlayingSeries();
          // assert
          expect(result, equals(tvSeries));
          // act
    });

    test('should throw a ServerException when response code 404', () async {
       when (mockHttpClient
       .get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
           .thenAnswer((_) async => http.Response('Not Found', 404));

       final call = dataSource.getNowPlayingSeries();
       expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Series', () {
    final tvSeries = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/popular.json'))
    ).tvSeries;

    test('should return list of Series Model when the response is 200',
            () async {
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series/popular.json'), 200));
          // act
          final result = await dataSource.getPopularSeries();
          // assert
          expect(result, equals(tvSeries));
          // act
        });

    test('should throw a ServerException when response code 404', () async {
      when (mockHttpClient
          .get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getPopularSeries();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Series', () {
    final tvSeries = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/top_rated.json'))
    ).tvSeries;

    test('should return list of Series Model when the response is 200',
            () async {
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series/top_rated.json'), 200));
          // act
          final result = await dataSource.getTopRatedSeries();
          // assert
          expect(result, equals(tvSeries));
          // act
        });

    test('should throw a ServerException when response code 404', () async {
      when (mockHttpClient
          .get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTopRatedSeries();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Search Series', () {
    final tvSeries = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/search_series.json'))
    ).tvSeries;
    const query = "spider";

    test('should return list of Series Model when the response is 200',
            () async {
          when(mockHttpClient.get(Uri.parse(
              '$BASE_URL/search/tv?$API_KEY&query=$query')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series/search_series.json'),
                  200));
          // act
          final result = await dataSource.searchSeries(query);
          // assert
          expect(result, equals(tvSeries));
          // act
        });

    test('should throw a ServerException when response code 404', () async {
      when (mockHttpClient
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.searchSeries(query);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Series Episode', () {
    final episodes = EpisodeResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/episode_series.json'))
    ).episodes;
    const id = 1;
    const season = 1;

    test('should return list of Series Model when the response is 200',
            () async {
          when(mockHttpClient.get(Uri.parse(
              '$BASE_URL/tv/$id}/season/$season}?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series/episode_series.json'),
                  200));
          // act
          final result = await dataSource.getEpisodes(id, season);
          // assert
          expect(result, equals(episodes));
          // act
        });

    test('should throw a ServerException when response code 404', () async {
      when (mockHttpClient
          .get(Uri.parse('$BASE_URL/tv/$id}/season/$season}?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getEpisodes(id, season);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Series detail ', () {
    final tvSeriesDetail = TvSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/detail.json'))
    );
    const id = 1;

    test('should return detail of series Model when the response is 200',
            () async {
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series/detail.json'), 200));
          // act
          final result = await dataSource.getSeriesDetail(id);
          // assert
          expect(result, equals(tvSeriesDetail));
          // act
        });

    test('should throw a ServerException when response code 404', () async {
      when (mockHttpClient
          .get(Uri.parse('$BASE_URL/tv/$id?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getSeriesDetail(id);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get series recommendation', () {
    final tvSeries = TvSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/recommendation.json'))
    ).tvSeries;
    const id = 1;

    test('should return detail of series Model when the response is 200',
            () async {
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series/recommendation.json'), 200));
          // act
          final result = await dataSource.getSeriesRecommendations(id);
          // assert
          expect(result, equals(tvSeries));
          // act
        });

    test('should throw a ServerException when response code 404', () async {
      when (mockHttpClient
          .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getSeriesRecommendations(id);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}