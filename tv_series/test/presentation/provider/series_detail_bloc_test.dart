import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/data_state.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/home_enum.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/usecase/get_watchlist_status.dart';
import 'package:core/domain/usecase/remove_watchlist.dart';
import 'package:core/domain/usecase/save_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_series_episode.dart';
import 'package:tv_series/domain/usecase/get_series_recommendations.dart';
import 'package:tv_series/domain/usecase/get_tv_series_detail.dart';
import 'package:tv_series/presentation/bloc/detail/series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/detail/series_detail_event.dart';
import 'package:tv_series/presentation/bloc/detail/series_detail_state.dart';

import '../../../../core/test/dummy_data/tv_series/dummy_objects.dart';
import 'series_domain_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetSeriesRecommendations,
  GetSeriesEpisodes,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late SeriesDetailBloc bloc;
  late MockGetSeriesDetail seriesDetail;
  late MockGetSeriesRecommendations seriesRecommendations;
  late MockGetSeriesEpisodes episodes;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    seriesDetail = MockGetSeriesDetail();
    seriesRecommendations = MockGetSeriesRecommendations();
    episodes = MockGetSeriesEpisodes();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = SeriesDetailBloc(
      seriesDetail,
      seriesRecommendations,
      mockGetWatchlistStatus,
      episodes,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tSeries = testSeriesList.map((e) => e.toEntity()).toList();
  final tSeriesDetail = testSeriesDetail.toEntity();
  final tSeasons = <Season, List<Episode>> {
    tvSeriesSeason.toEntity() : tvEpisodes.map((e) => e.toEntity()).toList(),
    tvSeriesSeason2.toEntity() : tvEpisodes.map((e) => e.toEntity()).toList(),
  };

  group('Get Series Detail', () {
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      "should get data from usecase until complete",
      build: () {
        when(
          seriesDetail.execute(tId)
        ).thenAnswer((_) async => Right(tSeriesDetail));
        when(
          mockGetWatchlistStatus.execute(tId, DataType.TvSeries)
        ).thenAnswer((_) async => true);
        when(
            episodes.execute(tId)
        ).thenAnswer((_) async => Right(tSeasons));
        when(
          seriesRecommendations.execute(tId)
        ).thenAnswer((_) async => Right(tSeries));
        return bloc;
      },
      act: (SeriesDetailBloc bloc) => bloc
        ..add(const FetchSeriesDetailEvent(tId))
        ..add(const FetchRecommendationSeriesDetailEvent(tId))
        ..add(const FetchEpisodeEvent(tId)),
      expect: () => [
        SeriesDetailState.initial(),
        SeriesDetailState(
          detailState: SuccessUiState(tSeriesDetail),
          recommendationState: const LoadingUiState(),
          seasonState: const LoadingUiState(),
          isFavorite: false
        ),
        SeriesDetailState(
            detailState: SuccessUiState(tSeriesDetail),
            recommendationState: SuccessUiState(tSeries),
            seasonState: const LoadingUiState(),
            isFavorite: false
        ),
        SeriesDetailState(
          detailState: SuccessUiState(tSeriesDetail),
          recommendationState: SuccessUiState(tSeries),
          seasonState: SuccessUiState(tSeasons),
          isFavorite: false
        ),
        SeriesDetailState(
            detailState: SuccessUiState(tSeriesDetail),
            recommendationState: SuccessUiState(tSeries),
            seasonState: SuccessUiState(tSeasons),
            isFavorite: true
        ),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      "should get data detail but error",
      build: () {
        when(
            seriesDetail.execute(tId)
        ).thenAnswer((_) async => Left(ServerFailure('Failure')));
        when(
            mockGetWatchlistStatus.execute(tId, DataType.TvSeries)
        ).thenAnswer((_) async => false);
        return bloc;
      },
      act: (SeriesDetailBloc bloc) => bloc
        ..add(const FetchSeriesDetailEvent(tId)),
      expect: () => [
        SeriesDetailState.initial(),
        const SeriesDetailState(
            detailState: ErrorUiState('Failure'),
            recommendationState: LoadingUiState(),
            seasonState: LoadingUiState(),
            isFavorite: false
        ),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      "should get data recommendation error",
      build: () {
        when(
            seriesRecommendations.execute(tId)
        ).thenAnswer((_) async => Left(ServerFailure('Error')));
        return bloc;
      },
      act: (SeriesDetailBloc bloc) => bloc
        ..add(const FetchRecommendationSeriesDetailEvent(tId)),
      expect: () => [
        SeriesDetailState.initial(),
        const SeriesDetailState(
            detailState: LoadingUiState(),
            recommendationState: ErrorUiState('Error'),
            seasonState: LoadingUiState(),
            isFavorite: false
        ),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      "should save usecase detail",
      build: () {
        when(mockSaveWatchlist.saveSeries(tSeriesDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatus.execute(tSeriesDetail.id, DataType.TvSeries))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (SeriesDetailBloc bloc) => bloc
        .add(ChangeWatchlistDetailEvent(true, tSeriesDetail)),
      expect: () => [
        const SeriesDetailState(
            detailState: LoadingUiState(),
            seasonState: LoadingUiState(),
            recommendationState: LoadingUiState(),
            isFavorite: true
        ),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      "should remove usecase detail",
      build: () {
        when(mockRemoveWatchlist.removeSeries(tSeriesDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatus.execute(tSeriesDetail.id, DataType.Movie))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (SeriesDetailBloc bloc) => bloc
          .add(ChangeWatchlistDetailEvent(false, tSeriesDetail)),
      expect: () => [
        const SeriesDetailState(
            detailState: LoadingUiState(),
            seasonState: LoadingUiState(),
            recommendationState: LoadingUiState(),
            isFavorite: false
        ),
      ],
    );
  });
}
