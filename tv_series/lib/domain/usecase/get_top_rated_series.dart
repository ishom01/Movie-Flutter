import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedSeries {
  final TvSeriesRepository repository;

  GetTopRatedSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedSeries();
  }
}
