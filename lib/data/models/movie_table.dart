import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:equatable/equatable.dart';

import '../../common/home_enum.dart';

class WatchlistTable extends Equatable {
  final int id;
  final int type;
  final String? title;
  final String? posterPath;
  final String? overview;

  WatchlistTable({
    required this.id,
    required this.type,
    required this.title,
    required this.posterPath,
    required this.overview
  });

  factory WatchlistTable.fromEntity(MovieDetail movie) => WatchlistTable(
        id: movie.id,
        title: movie.title,
        type: DataType.Movie.index,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory WatchlistTable.fromSeriesEntity(
      TvSeriesDetail series
  ) => WatchlistTable(
        id: series.id,
        title: series.name,
        type: DataType.TvSeries.index,
        posterPath: series.posterPath,
        overview: series.overview,
      );

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
        id: map['id'],
        type: map['type'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'type': type,
        'posterPath': posterPath,
        'overview': overview,
      };

  Watchlist toEntity() => Watchlist(
        id: id,
        overview: overview,
        path: posterPath,
        title: title,
        type: type
      );

  @override
  List<Object?> get props => [id, title, type, posterPath, overview];
}
