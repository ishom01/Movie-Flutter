import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/home_enum.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/data/sources/tv_series_remote_data_source.dart';
import 'package:core/data/sources/watch_list_local_data_source.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';
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
  var episodeMaps = {
    tvSeriesSeason.toEntity(): tvEpisodes.map((e) => e.toEntity()).toList(),
    tvSeriesSeason2.toEntity(): tvEpisodes.map((e) => e.toEntity()).toList()
  };
  var watchlistTable = WatchlistTable.fromSeriesEntity(seriesDetailEntity);

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
              .thenThrow(const SocketException('Failed to connect to the network'));

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
              .thenThrow(const SocketException('Failed to connect to the network'));

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
              .thenThrow(const SocketException('Failed to connect to the network'));

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
              .thenThrow(const SocketException('Failed to connect to the network'));

          final result = await repository.getSeriesRecommendations(id);
          verify(remoteDataSource.getSeriesRecommendations(id));

          expect(
              result,
              equals(Left(ConnectionFailure('Failed to connect to the network')))
          );
        });
  });

  group('Search Series', () {
    const query = "Sample";

    test('should return remote data when call success', () async {
      when(remoteDataSource.searchSeries(query))
          .thenAnswer((_) async => testSeriesList);

      final result = await repository.searchSeries(query);
      verify(remoteDataSource.searchSeries(query));

      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test(
        'should return server failure when the call to remote data source failed',
            () async {
          when(remoteDataSource.searchSeries(query))
              .thenThrow(ServerException());

          final result = await repository.searchSeries(query);
          verify(remoteDataSource.searchSeries(query));

          expect(
              result,
              equals(Left(ServerFailure('')))
          );
        });

    test(
        'should return server failure when device is not connected to internet',
            () async {
          when(remoteDataSource.searchSeries(query))
              .thenThrow(const SocketException('Failed to connect to the network'));

          final result = await repository.searchSeries(query);
          verify(remoteDataSource.searchSeries(query));

          expect(
              result,
              equals(Left(ConnectionFailure('Failed to connect to the network')))
          );
        });
  });

  group('Get episodes series', () {
    final id = testSeriesDetail.id;
    const seasonId = 1;
    const seasonId2 = 2;

    test('should return remote data when call success', () async {
      when(remoteDataSource.getSeriesDetail(id))
          .thenAnswer((_) async => testSeriesDetail);
      when(remoteDataSource.getEpisodes(id, seasonId))
          .thenAnswer((_) async => tvEpisodes);
      when(remoteDataSource.getEpisodes(id, seasonId2))
          .thenAnswer((_) async => tvEpisodes);

      final result = await repository.getEpisodes(id);
      verify(remoteDataSource.getEpisodes(id, seasonId));
      verify(remoteDataSource.getEpisodes(id, seasonId2));

      final resultList = result.getOrElse(() => {});
      expect(resultList, episodeMaps);
    });

    test(
        'should return server failure when the call to remote data source failed',
            () async {
          when(remoteDataSource.getSeriesDetail(id))
              .thenThrow(ServerException());
          when(remoteDataSource.getEpisodes(id, seasonId))
              .thenThrow(ServerException());

          final result = await repository.getEpisodes(id);
          verify(remoteDataSource.getSeriesDetail(id));
          verifyNever(remoteDataSource.getEpisodes(id, seasonId));

          expect(
              result,
              equals(Left(ServerFailure('')))
          );
        });

    test(
        'should return server failure when device is not connected to internet',
            () async {
          when(remoteDataSource.getSeriesDetail(id))
              .thenThrow(const SocketException('Failed to connect to the network'));
          when(remoteDataSource.getEpisodes(id, seasonId))
              .thenThrow(const SocketException('Failed to connect to the network'));

          final result = await repository.getEpisodes(id);
          verify(remoteDataSource.getSeriesDetail(id));
          verifyNever(remoteDataSource.getEpisodes(id, seasonId));

          expect(
              result,
              equals(Left(ConnectionFailure(
                  'Failed to connect to the network')))
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
              .thenThrow(const SocketException('Failed to connect to the network'));

          final result = await repository.getSeriesDetail(id);
          verify(remoteDataSource.getSeriesDetail(id));

          expect(
              result,
              equals(Left(ConnectionFailure('Failed to connect to the network')))
          );
        });
  });

  group('Check Is Added to Watchlist', () {

    test('should return local data has added in watchlist', () async {
      when(localDataSource.getWatchListById(watchlistTable.id,
          DataType.TvSeries))
          .thenAnswer((_) async => watchlistTable);

      final result = await repository.isAddedToWatchlist(watchlistTable.id);
      verify(localDataSource.getWatchListById(watchlistTable.id,
          DataType.TvSeries));

      expect(result, equals(true));
    });

    test('should return local data not has added in watchlist', () async {
      when(localDataSource.getWatchListById(watchlistTable.id,
          DataType.TvSeries))
          .thenAnswer((_) async => null);

      final result = await repository.isAddedToWatchlist(watchlistTable.id);
      verify(localDataSource.getWatchListById(watchlistTable.id,
          DataType.TvSeries));

      expect(result, equals(false));
    });
  });

  group('Remove Watchlist', () {

    test('should return success when success', () async {
      when(localDataSource.removeWatchlist(watchlistTable))
          .thenAnswer((_) async => "success");

      final result = await repository.removeWatchlist(seriesDetailEntity);
      verify(localDataSource.removeWatchlist(watchlistTable));

      expect(result, equals(const Right("success")));
    });

    test('should failed when query database', () async {
      when(localDataSource.removeWatchlist(watchlistTable))
          .thenThrow(DatabaseException(''));

      final result = await repository.removeWatchlist(seriesDetailEntity);
      verify(localDataSource.removeWatchlist(watchlistTable));

      expect(result, equals(Left(DatabaseFailure(''))));
    });
  });

  group('Insert Watchlist', () {

    test('should return success when success', () async {
      when(localDataSource.insertWatchlist(watchlistTable))
          .thenAnswer((_) async => "success");

      final result = await repository.saveWatchlist(seriesDetailEntity);
      verify(localDataSource.insertWatchlist(watchlistTable));

      expect(result, equals(const Right("success")));
    });

    test('should failed when query database', () async {
      when(localDataSource.insertWatchlist(watchlistTable))
          .thenThrow(DatabaseException(''));

      final result = await repository.saveWatchlist(seriesDetailEntity);
      verify(localDataSource.insertWatchlist(watchlistTable));

      expect(result, equals(Left(DatabaseFailure(''))));
    });
  });
}