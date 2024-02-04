import 'package:core/common/failure.dart';
import 'package:core/domain/entities/watchlist.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetWatchlist {
  final MovieRepository _repository;

  GetWatchlist(this._repository);

  Future<Either<Failure, List<Watchlist>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
