import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/home_enum.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/datasources/watch_list_local_data_source.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

import '../models/movie_table.dart';

class TvSeriesRepositoryImpl extends TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  final WatchListLocalDataSource localDataSource;

  TvSeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource
  });

  @override
  Future<Either<Failure, List<TvSeries>>> getNowPlayingSeries() async {
    try {
      final result = await remoteDataSource.getNowPlayingSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularSeries() async {
    try {
      final result = await remoteDataSource.getPopularSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getSeriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getSeriesRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getSeriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchSeries(String query) async {
    try {
      final result = await remoteDataSource.searchSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getWatchListById(id, DataType.TvSeries);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail series) async {
    try {
      final result = await localDataSource.removeWatchlist(
          WatchlistTable.fromSeriesEntity(series)
      );
      return Right(result);
    } on DatabaseException catch(e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail series) async {
    try {
      final result = await localDataSource.insertWatchlist(
          WatchlistTable.fromSeriesEntity(series)
      );
      return Right(result);
    } on DatabaseException catch(e) {
      return Left(DatabaseFailure(e.message));
    }
  }



  @override
  Future<Either<Failure, Map<Season, List<Episode>>>> getEpisodes(
      int id) async {
    try {
      final Map<Season, List<Episode>> seasonMaps = {};
      final detail = await remoteDataSource.getSeriesDetail(id);
      final seasons = detail.seasons.map((e) => e.toEntity()).toList();
      seasons.sort((season1, season2) =>
          season1.seasonNumber.compareTo(season2.seasonNumber));
      for (int i = 0; i < detail.seasons.length; i++) {
        final season = seasons[i];
        final episodes = await remoteDataSource.getEpisodes(detail.id,
            season.seasonNumber);
        if (episodes.isEmpty) continue;
        seasonMaps[season] = episodes.map((episode) => episode.toEntity())
            .toList();
      }
      return Right(seasonMaps);
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }}