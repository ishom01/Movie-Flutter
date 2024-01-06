import 'dart:convert';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

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

  group('get Series detail ', () {
    final tvSeriesDetail = TvSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/detail.json'))
    );
    final id = 1;

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
    final id = 1;

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