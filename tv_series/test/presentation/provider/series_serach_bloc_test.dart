import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/data_state.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_top_rated_series.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_event.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_state.dart';
import 'package:tv_series/presentation/bloc/search/series_search_bloc.dart';
import 'package:tv_series/presentation/bloc/search/series_search_event.dart';
import 'package:tv_series/presentation/bloc/search/series_search_state.dart';
import 'package:tv_series/presentation/bloc/top_rated/series_top_rated_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated/series_top_rated_event.dart';
import 'package:tv_series/presentation/bloc/top_rated/series_top_rated_state.dart';

import '../../../../core/test/dummy_data/tv_series/dummy_objects.dart';
import 'series_domain_test.mocks.dart';

@GenerateMocks([
  GetTopRatedSeries,
])
void main() {
  late SeriesSearchBloc bloc;
  late MockSearchSeries mockSearchSeries;

  setUp(() {
    mockSearchSeries = MockSearchSeries();
    bloc = SeriesSearchBloc(
      mockSearchSeries,
    );
  });

  final tSeries = testSeriesList.map((e) => e.toEntity()).toList();
  const key = "search";

  group('Get Search Series', () {
    blocTest<SeriesSearchBloc, SeriesSearchState>(
      "should get data from usecase until complete",
      build: () {
        when(
            mockSearchSeries.execute(key)
        ).thenAnswer((_) async => Right(tSeries));
        return bloc;
      },
      act: (SeriesSearchBloc bloc) => bloc
          .add(const SeriesSearchEvent(key)),
      expect: () => [
        const SeriesSearchState(
          key: key,
          seriesState: LoadingUiState(),
        ),
        SeriesSearchState(
          key: key,
          seriesState: SuccessUiState(tSeries),
        ),
      ],
    );

    blocTest<SeriesSearchBloc, SeriesSearchState>(
      "should get data from usecase util failed",
      build: () {
        when(
            mockSearchSeries.execute(key)
        ).thenAnswer((_) async => Left(ServerFailure('Failure')));
        return bloc;
      },
      act: (SeriesSearchBloc bloc) => bloc
          .add(const SeriesSearchEvent(key)),
      expect: () => [
        const SeriesSearchState(
          key: key,
          seriesState: LoadingUiState(),
        ),
        const SeriesSearchState(
          key: key,
          seriesState: ErrorUiState('Failure'),
        ),
      ],
    );
  });
}
