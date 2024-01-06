import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class RemoveWatchlist {
  final MovieRepository movieRepository;
  final TvSeriesRepository seriesRepository;

  RemoveWatchlist(this.movieRepository, this.seriesRepository);

  Future<Either<Failure, String>> removeMovie(MovieDetail movie) {
    return movieRepository.removeWatchlist(movie);
  }

  Future<Either<Failure, String>> removeSeries(TvSeriesDetail seriesDetail) {
    return seriesRepository.removeWatchlist(seriesDetail);
  }
}
