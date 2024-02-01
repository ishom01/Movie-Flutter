// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/provider/movie_detail_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/common/home_enum.dart' as _i6;
import 'package:ditonton/domain/entities/movie.dart' as _i9;
import 'package:movie/domain/entities/movie_detail.dart' as _i7;
import 'package:ditonton/domain/entities/tv_series_detail.dart' as _i7;
import '../../../movie/lib/domain/repositories/movie_repository.dart' as _i2;
import 'package:ditonton/domain/repositories/tv_series_repository.dart' as _i2;
import 'package:movie/domain/usecase/get_movie_detail.dart' as _i4;
import 'package:movie/domain/usecase/get_movie_recommendations.dart' as _i8;
import 'package:ditonton/domain/usecases/get_watchlist_status.dart' as _i10;
import 'package:core/domain/usecase/remove_watchlist.dart' as _i12;
import 'package:ditonton/domain/usecases/save_watchlist.dart' as _i11;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeMovieRepository extends _i1.Fake implements _i2.MovieRepository {}

class _FakeTvSeriesRepository extends _i1.Fake
    implements _i2.TvSeriesRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetMovieDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieDetail extends _i1.Mock implements _i4.GetMovieDetail {
  MockGetMovieDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.MovieDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, _i7.MovieDetail>>.value(
              _FakeEither<_i6.Failure, _i7.MovieDetail>())) as _i5
          .Future<_i3.Either<_i6.Failure, _i7.MovieDetail>>);
}

/// A class which mocks [GetMovieRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieRecommendations extends _i1.Mock
    implements _i8.GetMovieRecommendations {
  MockGetMovieRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.Movie>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i9.Movie>>>.value(
              _FakeEither<_i6.Failure, List<_i9.Movie>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.Movie>>>);
}

/// A class which mocks [GetWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatus extends _i1.Mock
    implements _i10.GetWatchListStatus {
  MockGetWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get movieRepository =>
      (super.noSuchMethod(Invocation.getter(#movieRepository),
          returnValue: _FakeMovieRepository()) as _i2.MovieRepository);

  @override
  _i2.TvSeriesRepository get seriesRepository =>
      (super.noSuchMethod(Invocation.getter(#seriesRepository),
          returnValue: _FakeTvSeriesRepository()) as _i2.TvSeriesRepository);


  @override
  _i5.Future<bool> execute(int? id, _i6.DataType type) =>
      (super.noSuchMethod(Invocation.method(#execute, [id, type]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
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
          returnValue: _FakeTvSeriesRepository()) as _i2.TvSeriesRepository);

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
          returnValue: _FakeTvSeriesRepository()) as _i2.TvSeriesRepository);

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
