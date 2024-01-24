import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/home_enum.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_series_episode.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/provider/series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_series/dummy_objects.dart';
import 'movie_detail_notifier_test.mocks.dart';
import 'series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  SaveWatchlist,
  RemoveWatchlist,
  GetSeriesRecommendations,
  GetWatchListStatus,
  GetTvSeriesDetail,
  GetSeriesEpisodes,
])
void main() {
  late SeriesDetailNotifier provider;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late MockGetSeriesEpisodes mockGetSeriesEpisodes;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    mockGetSeriesEpisodes = MockGetSeriesEpisodes();
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    provider = SeriesDetailNotifier(
        getSeriesEpisodes: mockGetSeriesEpisodes,
        getSeriesRecommendations: mockGetSeriesRecommendations,
        getTvSeriesDetail: mockGetTvSeriesDetail,
        getWatchListStatus: mockGetWatchListStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist)
    ..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tId = 1;
  final seriesDetail = testSeriesDetail.toEntity();
  final seriesList = testSeriesList.map((e) => e.toEntity()).toList();
  var episodeMaps = {
    tvSeriesSeason.toEntity(): tvEpisodes.map((e) => e.toEntity()).toList(),
    tvSeriesSeason2.toEntity(): tvEpisodes.map((e) => e.toEntity()).toList()
  };

  void _arrangeUseCase() {
    when(mockGetTvSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(seriesDetail));
    when(mockGetSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(seriesList));
    when(mockGetSeriesEpisodes.execute(tId))
        .thenAnswer((_) async => Right(episodeMaps));
  }

  group('get detail series', () {
    test('should get data from useCase', () async {
      // arrange
      _arrangeUseCase();

      // act
      await provider.fetchSeriesDetail(tId);

      //assert
      verify(mockGetTvSeriesDetail.execute(tId));
      verify(mockGetSeriesRecommendations.execute(tId));
      verify(mockGetSeriesEpisodes.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUseCase();
      // act
      provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change series when data is gotten successfully', () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loaded);
      expect(provider.detail, seriesDetail);
      expect(listenerCallCount, 4);
    });

    test('should change recommendation series when data is gotten successfully',
        () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loaded);
      expect(provider.seriesRecommendations, seriesList);
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchListStatus.execute(1, DataType.TvSeries))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(tId);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.saveSeries(seriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatus.execute(seriesDetail.id, DataType.TvSeries))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(seriesDetail);
      // assert
      verify(mockSaveWatchlist.saveSeries(seriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.removeSeries(seriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListStatus.execute(seriesDetail.id, DataType.TvSeries))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(seriesDetail);
      // assert
      verify(mockRemoveWatchlist.removeSeries(seriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.saveSeries(seriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchListStatus.execute(seriesDetail.id, DataType.TvSeries))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(seriesDetail);
      // assert
      verify(mockGetWatchListStatus.execute(seriesDetail.id, DataType.TvSeries));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.saveSeries(seriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatus.execute(seriesDetail.id, DataType.TvSeries))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(seriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(seriesList));
      when(mockGetSeriesEpisodes.execute(tId))
          .thenAnswer((_) async => Right(episodeMaps));
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}