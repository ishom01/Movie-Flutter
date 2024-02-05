import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/data_state.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_popular_series.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_event.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_state.dart';

import '../../../../core/test/dummy_data/tv_series/dummy_objects.dart';
import 'series_domain_test.mocks.dart';

@GenerateMocks([
  GetPopularSeries,
])
void main() {
  late SeriesPopularBloc bloc;
  late MockGetPopularSeries mockGetPopularSeries;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    bloc = SeriesPopularBloc(
      mockGetPopularSeries,
    );
  });

  final tSeries = testSeriesList.map((e) => e.toEntity()).toList();

  group('Get Popular Series', () {
    blocTest<SeriesPopularBloc, SeriesPopularState>(
      "should get data from usecase until complete",
      build: () {
        when(
            mockGetPopularSeries.execute()
        ).thenAnswer((_) async => Right(tSeries));
        return bloc;
      },
      act: (SeriesPopularBloc bloc) => bloc
          .add(const SeriesPopularEvent()),
      expect: () => [
        SeriesPopularState.initial(),
        SeriesPopularState(
          seriesState: SuccessUiState(tSeries),
        ),
      ],
    );

    blocTest<SeriesPopularBloc, SeriesPopularState>(
      "should get data from usecase util failed",
      build: () {
        when(
            mockGetPopularSeries.execute()
        ).thenAnswer((_) async => Left(ServerFailure('Failure')));
        return bloc;
      },
      act: (SeriesPopularBloc bloc) => bloc
          .add(const SeriesPopularEvent()),
      expect: () => [
        SeriesPopularState.initial(),
        const SeriesPopularState(
          seriesState: ErrorUiState('Failure'),
        ),
      ],
    );
  });
}
