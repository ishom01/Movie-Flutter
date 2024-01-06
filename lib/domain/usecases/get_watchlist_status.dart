import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

import '../../common/home_enum.dart';

class GetWatchListStatus {
  final MovieRepository movieRepository;
  final TvSeriesRepository seriesRepository;

  GetWatchListStatus(this.movieRepository, this.seriesRepository);

  Future<bool> execute(int id, DataType type) async {
    if (type == DataType.Movie) {
      return movieRepository.isAddedToWatchlist(id);
    }
    return seriesRepository.isAddedToWatchlist(id);
  }
}
