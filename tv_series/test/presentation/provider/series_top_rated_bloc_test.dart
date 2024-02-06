import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/data_state.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_top_rated_series.dart';
import 'package:tv_series/presentation/bloc/top_rated/series_top_rated_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated/series_top_rated_event.dart';
import 'package:tv_series/presentation/bloc/top_rated/series_top_rated_state.dart';

import '../../../../core/test/dummy_data/tv_series/dummy_objects.dart';
import 'series_domain_test.mocks.dart';

@GenerateMocks([
  GetTopRatedSeries,
])
void main() {
  late SeriesTopRatedBloc bloc;
  late MockGetTopRatedSeries mockGetTopRatedSeries;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    bloc = SeriesTopRatedBloc(
      mockGetTopRatedSeries,
    );
  });

  final tSeries = testSeriesList.map((e) => e.toEntity()).toList();

  group('Get Top Rated Series', () {
    blocTest<SeriesTopRatedBloc, SeriesTopRatedState>(
      "should get data from usecase until complete",
      build: () {
        when(
            mockGetTopRatedSeries.execute()
        ).thenAnswer((_) async => Right(tSeries));
        return bloc;
      },
      act: (SeriesTopRatedBloc bloc) => bloc
          .add(const SeriesTopRatedEvent()),
      expect: () => [
        SeriesTopRatedState.initial(),
        SeriesTopRatedState(
          seriesState: SuccessUiState(tSeries),
        ),
      ],
    );

    blocTest<SeriesTopRatedBloc, SeriesTopRatedState>(
      "should get data from usecase util failed",
      build: () {
        when(
            mockGetTopRatedSeries.execute()
        ).thenAnswer((_) async => Left(ServerFailure('Failure')));
        return bloc;
      },
      act: (SeriesTopRatedBloc bloc) => bloc
          .add(const SeriesTopRatedEvent()),
      expect: () => [
        SeriesTopRatedState.initial(),
        const SeriesTopRatedState(
          seriesState: ErrorUiState('Failure'),
        ),
      ],
    );
  });
}
