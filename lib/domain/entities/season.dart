import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final int id;
  final String name;
  final String? airDate;
  final int episodeCount;
  final String? overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    airDate,
    episodeCount,
    overview,
    posterPath,
    seasonNumber,
    voteAverage
  ];
}
