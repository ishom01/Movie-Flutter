// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/provider/movie_detail_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/common/home_enum.dart';
import 'package:dartz/dartz.dart' as _i3;
import 'package:core/common/failure.dart' as _i6;
import 'package:core/domain/entities/tv_series_detail.dart' as _i7;
import 'package:core/domain/entities/tv_series.dart' as _i7;
import 'package:core/domain/entities/movie_detail.dart' as _i7;
import 'package:core/domain/entities/episode.dart' as _i7;
import 'package:core/domain/entities/season.dart' as _i7;
import 'package:core/domain/entities/tv_series.dart' as _i7;
import 'package:core/domain/repositories/movie_repository.dart' as _i2;
import 'package:core/domain/repositories/tv_series_repository.dart' as _i2;
import 'package:tv_series/domain/usecase/get_now_playing_series.dart' as _i4;
import 'package:tv_series/domain/usecase/get_popular_series.dart' as _i4;
import 'package:tv_series/domain/usecase/get_series_episode.dart' as _i4;
import 'package:tv_series/domain/usecase/get_series_recommendations.dart' as _i4;
import 'package:tv_series/domain/usecase/get_top_rated_series.dart' as _i4;
import 'package:tv_series/domain/usecase/get_tv_series_detail.dart' as _i4;
import 'package:tv_series/domain/usecase/search_series.dart' as _i4;
import 'package:core/domain/usecase/get_watchlist_status.dart' as _i12;
import 'package:core/domain/usecase/remove_watchlist.dart' as _i12;
import 'package:core/domain/usecase/save_watchlist.dart' as _i11;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeSeriesRepository extends _i1.Fake implements _i2.TvSeriesRepository {}

class _FakeMovieRepository extends _i1.Fake implements _i2.MovieRepository {}


class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetTvSeriesDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesDetail extends _i1.Mock implements _i4.GetTvSeriesDetail {
  MockGetSeriesDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TvSeriesDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, _i7.TvSeriesDetail>>.value(
              _FakeEither<_i6.Failure, _i7.TvSeriesDetail>())) as _i5
          .Future<_i3.Either<_i6.Failure, _i7.TvSeriesDetail>>);
}

/// A class which mocks [GetTopRatedSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedSeries extends _i1.Mock implements _i4.GetTopRatedSeries {
  MockGetTopRatedSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
              _FakeEither<_i6.Failure, List<_i7.TvSeries>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}

/// A class which mocks [GetSeriesRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesRecommendations extends _i1.Mock implements
    _i4.GetSeriesRecommendations {
  MockGetSeriesRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute(id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
              _FakeEither<_i6.Failure, List<_i7.TvSeries>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}

/// A class which mocks [GetPopularSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularSeries extends _i1.Mock implements
    _i4.GetPopularSeries {
  MockGetPopularSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
              _FakeEither<_i6.Failure, List<_i7.TvSeries>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}

/// A class which mocks [GetNowPlayingSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingSeries extends _i1.Mock implements
    _i4.GetNowPlayingSeries {
  MockGetNowPlayingSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
              _FakeEither<_i6.Failure, List<_i7.TvSeries>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}

/// A class which mocks [GetNowPlayingSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchSeries extends _i1.Mock implements
    _i4.SearchSeries {
  MockSearchSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute(key) =>
      (super.noSuchMethod(Invocation.method(#execute, [key]),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
              _FakeEither<_i6.Failure, List<_i7.TvSeries>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}

/// A class which mocks [GetSeriesEpisodes].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesEpisodes extends _i1.Mock implements _i4.GetSeriesEpisodes {
  MockGetSeriesEpisodes() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure,
      Map<_i7.Season, List<_i7.Episode>>>> execute(id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure,
              Map<_i7.Season, List<_i7.Episode>>>>.value(
              _FakeEither<_i6.Failure, Map<_i7.Season, List<_i7.Episode>>>())) as _i5
          .Future<_i3.Either<_i6.Failure, Map<_i7.Season, List<_i7.Episode>>>>);
}



/// A class which mocks [SaveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlist extends _i1.Mock implements _i11.SaveWatchlist {
  MockSaveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get movieRepository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as _i2.MovieRepository);

  @override
  _i2.TvSeriesRepository get seriesRepository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as _i2.TvSeriesRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> saveMovie(
      _i7.MovieDetail movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
          returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
              _FakeEither<_i6.Failure, String>()))
      as _i5.Future<_i3.Either<_i6.Failure, String>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> saveSeries(
      _i7.TvSeriesDetail detail) =>
      (super.noSuchMethod(Invocation.method(#execute, [detail]),
          returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
              _FakeEither<_i6.Failure, String>()))
      as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlist extends _i1.Mock implements _i12.RemoveWatchlist {
  MockRemoveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get movieRepository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as _i2.MovieRepository);

  @override
  _i2.TvSeriesRepository get seriesRepository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as _i2.TvSeriesRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> removeMovie(
      _i7.MovieDetail movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
          returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
              _FakeEither<_i6.Failure, String>()))
      as _i5.Future<_i3.Either<_i6.Failure, String>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> removeSeries(
      _i7.TvSeriesDetail seriesDetail) =>
      (super.noSuchMethod(Invocation.method(#execute, [seriesDetail]),
          returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
              _FakeEither<_i6.Failure, String>()))
      as _i5.Future<_i3.Either<_i6.Failure, String>>);

}

/// A class which mocks [GetWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatus extends _i1.Mock implements
    _i12.GetWatchListStatus {
  MockGetWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get movieRepository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as _i2.MovieRepository);

  @override
  _i2.TvSeriesRepository get seriesRepository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as _i2.TvSeriesRepository);

  @override
  _i5.Future<bool> execute(int id, DataType type) =>
      (super.noSuchMethod(Invocation.method(#execute, [id, type]),
          returnValue: _i5.Future<bool>.value(false))
      as _i5.Future<bool>);
}