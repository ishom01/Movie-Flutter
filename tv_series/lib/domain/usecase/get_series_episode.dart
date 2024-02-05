import 'package:core/common/failure.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class GetSeriesEpisodes {
  final TvSeriesRepository repository;

  GetSeriesEpisodes(this.repository);

  Future<Either<Failure, Map<Season, List<Episode>>>> execute(int id) async {
    return await repository.getEpisodes(id);
  }
}