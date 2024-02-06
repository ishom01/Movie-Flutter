import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/data_state.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_popular_series.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_event.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_state.dart';

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

  final tSeries1 = TvSeries(
      adult: false,
      backdropPath: 'path.jpg',
      genreIds: const [
        1,
        2,
      ],
      id: 1,
      originCountry: const [
        "English"
      ],
      originalLanguage: "English",
      originalName: "Sample Name",
      overview: "Description",
      popularity: 120,
      posterPath: "path.jpg",
      firstAirDate: "2012-12-12",
      name: "Sample Name",
      voteCount: 1,
      voteAverage: 5.0
  );
  final tSeries = [tSeries1];

  group('Get Popular Series', () {
    blocTest<SeriesPopularBloc, SeriesPopularState>(
      "should get data from usecase until complete",
      build: () {
        when(
            mockGetPopularSeries.execute()
        ).thenAnswer((_) async => Right(tSeries));
        return bloc;
      },
      act: (SeriesPopularBloc bloc) => bloc.add(const SeriesPopularEvent()),
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
