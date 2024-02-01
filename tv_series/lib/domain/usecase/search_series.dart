import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class SearchSeries {
  final TvSeriesRepository repository;

  SearchSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchSeries(query);
  }
}
