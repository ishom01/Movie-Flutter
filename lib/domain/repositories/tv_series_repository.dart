import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedSeries();
  Future<Either<Failure, TvSeriesDetail>> getSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getSeriesRecommendations(int id);
  Future<Either<Failure, List<TvSeries>>> searchSeries(String query);

  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail series);
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail series);
  Future<bool> isAddedToWatchlist(int id);
}