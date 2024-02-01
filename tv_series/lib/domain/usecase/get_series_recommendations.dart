import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class GetSeriesRecommendations {
  final TvSeriesRepository repository;

  GetSeriesRecommendations(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getSeriesRecommendations(id);
  }
}