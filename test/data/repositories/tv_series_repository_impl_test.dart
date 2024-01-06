import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/datasources/watch_list_local_data_source.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_series/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepository repository;
  late TvSeriesRemoteDataSource remoteDataSource;
  late WatchListLocalDataSource localDataSource;

  var seriesList = testSeriesList.map((e) => e.toEntity());
  var seriesDetailEntity = testSeriesDetail.toEntity();

  setUp(() {
    remoteDataSource = MockTvSeriesRemoteDataSource();
    localDataSource = MockWatchlistLocalDataSource();
    repository = TvSeriesRepositoryImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource
    );
  });

  group('Now Playing Series', () {
    test('should return remote data when call success', () async {
      when(remoteDataSource.getNowPlayingSeries())
          .thenAnswer((_) async => testSeriesList);

      final result = await repository.getNowPlayingSeries();
      verify(remoteDataSource.getNowPlayingSeries());

      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test(
        'should return server failure when the call to remote data source failed',
            () async {
          when(remoteDataSource.getNowPlayingSeries())
              .thenThrow(ServerException());

          final result = await repository.getNowPlayingSeries();
          verify(remoteDataSource.getNowPlayingSeries());

          expect(
              result,
              equals(Left(ServerFailure('')))
          );
        });

    test(
        'should return server failure when device is not connected to internet',
            () async {
          when(remoteDataSource.getNowPlayingSeries())
              .thenThrow(SocketException('Failed to connect to the network'));

          final result = await repository.getNowPlayingSeries();
          verify(remoteDataSource.getNowPlayingSeries());

          expect(
              result,
              equals(Left(ConnectionFailure('Failed to connect to the network')))
          );
      });
  });

  group('Popular Series', () {
    test('should return remote data when call success', () async {
      when(remoteDataSource.getPopularSeries())
          .thenAnswer((_) async => testSeriesList);

      final result = await repository.getPopularSeries();
      verify(remoteDataSource.getPopularSeries());

      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test(
        'should return server failure when the call to remote data source failed',
            () async {
          when(remoteDataSource.getPopularSeries())
              .thenThrow(ServerException());

          final result = await repository.getPopularSeries();
          verify(remoteDataSource.getPopularSeries());

          expect(
              result,
              equals(Left(ServerFailure('')))
          );
        });

    test(
        'should return server failure when device is not connected to internet',
            () async {
          when(remoteDataSource.getPopularSeries())
              .thenThrow(SocketException('Failed to connect to the network'));

          final result = await repository.getPopularSeries();
          verify(remoteDataSource.getPopularSeries());

          expect(
              result,
              equals(Left(ConnectionFailure('Failed to connect to the network')))
          );
        });
  });

  group('Top Rated Series', () {
    test('should return remote data when call success', () async {
      when(remoteDataSource.getTopRatedSeries())
          .thenAnswer((_) async => testSeriesList);

      final result = await repository.getTopRatedSeries();
      verify(remoteDataSource.getTopRatedSeries());

      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test(
        'should return server failure when the call to remote data source failed',
            () async {
          when(remoteDataSource.getTopRatedSeries())
              .thenThrow(ServerException());

          final result = await repository.getTopRatedSeries();
          verify(remoteDataSource.getTopRatedSeries());

          expect(
              result,
              equals(Left(ServerFailure('')))
          );
        });

    test(
        'should return server failure when device is not connected to internet',
            () async {
          when(remoteDataSource.getTopRatedSeries())
              .thenThrow(SocketException('Failed to connect to the network'));

          final result = await repository.getTopRatedSeries();
          verify(remoteDataSource.getTopRatedSeries());

          expect(
              result,
              equals(Left(ConnectionFailure('Failed to connect to the network')))
          );
        });
  });

  group('Recommendation Series', () {
    var id = 1;
    
    test('should return remote data when call success', () async {
      when(remoteDataSource.getSeriesRecommendations(id))
          .thenAnswer((_) async => testSeriesList);

      final result = await repository.getSeriesRecommendations(id);
      verify(remoteDataSource.getSeriesRecommendations(id));

      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test(
        'should return server failure when the call to remote data source failed',
            () async {
          when(remoteDataSource.getSeriesRecommendations(id))
              .thenThrow(ServerException());

          final result = await repository.getSeriesRecommendations(id);
          verify(remoteDataSource.getSeriesRecommendations(id));

          expect(
              result,
              equals(Left(ServerFailure('')))
          );
        });

    test(
        'should return server failure when device is not connected to internet',
            () async {
          when(remoteDataSource.getSeriesRecommendations(id))
              .thenThrow(SocketException('Failed to connect to the network'));

          final result = await repository.getSeriesRecommendations(id);
          verify(remoteDataSource.getSeriesRecommendations(id));

          expect(
              result,
              equals(Left(ConnectionFailure('Failed to connect to the network')))
          );
        });
  });

  group('Detail Series', () {
    var id = 1;

    test('should return remote data when call success', () async {
      when(remoteDataSource.getSeriesDetail(id))
          .thenAnswer((_) async => testSeriesDetail);

      final result = await repository.getSeriesDetail(id);
      verify(remoteDataSource.getSeriesDetail(id));

      expect(result, equals(Right(seriesDetailEntity)));
    });

    test(
        'should return server failure when the call to remote data source failed',
            () async {
          when(remoteDataSource.getSeriesDetail(id))
              .thenThrow(ServerException());

          final result = await repository.getSeriesDetail(id);
          verify(remoteDataSource.getSeriesDetail(id));

          expect(
              result,
              equals(Left(ServerFailure('')))
          );
        });

    test(
        'should return server failure when device is not connected to internet',
            () async {
          when(remoteDataSource.getSeriesDetail(id))
              .thenThrow(SocketException('Failed to connect to the network'));

          final result = await repository.getSeriesDetail(id);
          verify(remoteDataSource.getSeriesDetail(id));

          expect(
              result,
              equals(Left(ConnectionFailure('Failed to connect to the network')))
          );
        });
  });
}