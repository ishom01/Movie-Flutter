import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import '../../../tv_series/lib/domain/usecase/get_now_playing_series.dart';
import '../../../tv_series/lib/domain/usecase/get_popular_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_series/dummy_objects.dart';
import 'now_playing_series_notifier_test.mocks.dart';
import 'popular_series_notifier_test.mocks.dart';
import 'top_rated_series_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries, GetNowPlayingSeries, GetPopularSeries])
void main() {
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late TvSeriesListNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    notifier = TvSeriesListNotifier(
      getTopRatedSeries: mockGetTopRatedSeries,
      getPopularSeries: mockGetPopularSeries,
      getNowPlayingSeries: mockGetNowPlayingSeries,
    )
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tSeriesList = testSeriesList.map((e) => e.toEntity()).toList();

  group('now playing series', () {
    test('initialState should be Empty', () {
      expect(notifier.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      notifier.fetchNowPlayingSeries();
      // assert
      verify(mockGetNowPlayingSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      notifier.fetchNowPlayingSeries();
      // assert
      expect(notifier.nowPlayingState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await notifier.fetchNowPlayingSeries();
      // assert
      expect(notifier.nowPlayingState, RequestState.Loaded);
      expect(notifier.nowPlayingSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchNowPlayingSeries();
      // assert
      expect(notifier.nowPlayingState, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular series', () {
    test('initialState should be Empty', () {
      expect(notifier.popularState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      notifier.fetchPopularSeries();
      // assert
      verify(mockGetPopularSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      notifier.fetchPopularSeries();
      // assert
      expect(notifier.popularState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await notifier.fetchPopularSeries();
      // assert
      expect(notifier.popularState, RequestState.Loaded);
      expect(notifier.popularSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchPopularSeries();
      // assert
      expect(notifier.popularState, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated series', () {
    test('initialState should be Empty', () {
      expect(notifier.topRatedSeriesState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      notifier.fetchTopRatedSeries();
      // assert
      verify(mockGetTopRatedSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      notifier.fetchTopRatedSeries();
      // assert
      expect(notifier.topRatedSeriesState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await notifier.fetchTopRatedSeries();
      // assert
      expect(notifier.topRatedSeriesState, RequestState.Loaded);
      expect(notifier.topRatedSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchTopRatedSeries();
      // assert
      expect(notifier.topRatedSeriesState, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
