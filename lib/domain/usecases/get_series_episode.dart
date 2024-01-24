import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetSeriesEpisodes {
  final TvSeriesRepository repository;

  GetSeriesEpisodes(this.repository);

  Future<Either<Failure, Map<Season, List<Episode>>>> execute(int id) async {
    return await repository.getEpisodes(id);
  }
}