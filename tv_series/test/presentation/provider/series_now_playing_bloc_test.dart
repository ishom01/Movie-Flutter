import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/data_state.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_now_playing_series.dart';
import 'package:tv_series/presentation/bloc/now_playing/series_now_playing_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing/series_now_playing_event.dart';
import 'package:tv_series/presentation/bloc/now_playing/series_now_playing_state.dart';

import '../../../../core/test/dummy_data/tv_series/dummy_objects.dart';
import 'series_domain_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingSeries,
])
void main() {
  late SeriesNowPlayingBloc bloc;
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;

  setUp(() {
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    bloc = SeriesNowPlayingBloc(
      mockGetNowPlayingSeries,
    );
  });

  final tSeries = testSeriesList.map((e) => e.toEntity()).toList();

  group('Get Top Rated Series', () {
    blocTest<SeriesNowPlayingBloc, SeriesNowPlayingState>(
      "should get data from usecase until complete",
      build: () {
        when(
            mockGetNowPlayingSeries.execute()
        ).thenAnswer((_) async => Right(tSeries));
        return bloc;
      },
      act: (SeriesNowPlayingBloc bloc) => bloc
          .add(const SeriesNowPlayingEvent()),
      expect: () => [
        SeriesNowPlayingState.initial(),
        SeriesNowPlayingState(
          seriesState: SuccessUiState(tSeries),
        ),
      ],
    );

    blocTest<SeriesNowPlayingBloc, SeriesNowPlayingState>(
      "should get data from usecase util failed",
      build: () {
        when(
            mockGetNowPlayingSeries.execute()
        ).thenAnswer((_) async => Left(ServerFailure('Failure')));
        return bloc;
      },
      act: (SeriesNowPlayingBloc bloc) => bloc
          .add(const SeriesNowPlayingEvent()),
      expect: () => [
        SeriesNowPlayingState.initial(),
        const SeriesNowPlayingState(
          seriesState: ErrorUiState('Failure'),
        ),
      ],
    );
  });
}
