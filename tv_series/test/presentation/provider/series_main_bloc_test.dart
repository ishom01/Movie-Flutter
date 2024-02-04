import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/data_state.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_now_playing_series.dart';
import 'package:tv_series/domain/usecase/get_popular_series.dart';
import 'package:tv_series/domain/usecase/get_top_rated_series.dart';
import 'package:tv_series/presentation/bloc/main/series_main_bloc.dart';
import 'package:tv_series/presentation/bloc/main/series_main_event.dart';
import 'package:tv_series/presentation/bloc/main/series_main_state.dart';

import '../../../../core/test/dummy_data/tv_series/dummy_objects.dart';
import 'series_domain_test.mocks.dart';

@GenerateMocks([
  GetPopularSeries,
  GetTopRatedSeries,
  GetNowPlayingSeries,
])
void main() {
  late SeriesMainBloc bloc;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    bloc = SeriesMainBloc(
      mockGetPopularSeries,
      mockGetNowPlayingSeries,
      mockGetTopRatedSeries,
    );
  });

  final tSeries = testSeriesList.map((e) => e.toEntity()).toList();

  group('Get Main series', () {
    blocTest<SeriesMainBloc, SeriesMainState>(
      "should get data from usecase until complete",
      build: () {
        when(
          mockGetPopularSeries.execute()
        ).thenAnswer((_) async => Right(tSeries));
        when(
          mockGetTopRatedSeries.execute()
        ).thenAnswer((_) async => Right(tSeries));
        when(
          mockGetNowPlayingSeries.execute()
        ).thenAnswer((_) async => Right(tSeries));
        return bloc;
      },
      act: (SeriesMainBloc bloc) => bloc
        ..add(const SeriesMainPopularEvent())
        ..add(const SeriesMainNowPlayingEvent())
        ..add(const SeriesMainTopRatedEvent()),
      expect: () => [
        SeriesMainState.initial(),
        SeriesMainState(
          popularState: SuccessUiState(tSeries),
          nowPlayingState: const LoadingUiState(),
          topRatedState: const LoadingUiState()
        ),
        SeriesMainState(
          popularState: SuccessUiState(tSeries),
          nowPlayingState: SuccessUiState(tSeries),
          topRatedState: const LoadingUiState(),
        ),
        SeriesMainState(
          popularState: SuccessUiState(tSeries),
          nowPlayingState: SuccessUiState(tSeries),
          topRatedState: SuccessUiState(tSeries),
        ),
      ],
    );

    blocTest<SeriesMainBloc, SeriesMainState>(
      "should get popular tapi error",
      build: () {
        when(
          mockGetPopularSeries.execute()
        ).thenAnswer((_) async => Left(ServerFailure('Error')));
        return bloc;
      },
      act: (SeriesMainBloc bloc) => bloc
        ..add(const SeriesMainPopularEvent()),
      expect: () => [
        SeriesMainState.initial(),
        const SeriesMainState(
            popularState: ErrorUiState('Error'),
            nowPlayingState: LoadingUiState(),
            topRatedState: LoadingUiState()
        ),
      ],
    );

    blocTest<SeriesMainBloc, SeriesMainState>(
      "should get top playing tapi error",
      build: () {
        when(
          mockGetTopRatedSeries.execute()
        ).thenAnswer((_) async => Left(ServerFailure('Error')));
        return bloc;
      },
      act: (SeriesMainBloc bloc) => bloc
        ..add(const SeriesMainTopRatedEvent()),
      expect: () => [
        SeriesMainState.initial(),
        const SeriesMainState(
            popularState: LoadingUiState(),
            nowPlayingState: LoadingUiState(),
            topRatedState: ErrorUiState('Error'),
        ),
      ],
    );

    blocTest<SeriesMainBloc, SeriesMainState>(
      "should get now playing tapi error",
      build: () {
        when(
          mockGetNowPlayingSeries.execute()
        ).thenAnswer((_) async => Left(ServerFailure('Error')));
        return bloc;
      },
      act: (SeriesMainBloc bloc) => bloc
        ..add(const SeriesMainNowPlayingEvent()),
      expect: () => [
        SeriesMainState.initial(),
        const SeriesMainState(
          popularState: LoadingUiState(),
          nowPlayingState: ErrorUiState('Error'),
          topRatedState: LoadingUiState(),
        ),
      ],
    );
  });
}
