import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/data_state.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecase/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/top_rated/movie_top_rated_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/movie_top_rated_event.dart';
import 'package:movie/presentation/bloc/top_rated/movie_top_rated_state.dart';

import 'movie_domain_test.mocks.dart';

@GenerateMocks([
  GetTopRatedMovies,
])
void main() {
  late MovieTopRatedBloc bloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = MovieTopRatedBloc(
      mockGetTopRatedMovies,
    );
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  group('Get Movie Top Rated', () {
    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      "should get main usecase completed",
      build: () {
        when(
          mockGetTopRatedMovies.execute()
        ).thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (MovieTopRatedBloc bloc) => bloc.add(const MovieTopRatedEvent()),
      expect: () => [
        MovieTopRatedState.initial(),
        MovieTopRatedState(
          movieState: SuccessUiState(tMovies),
        ),
      ],
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      "should get main usecase but failed all",
      build: () {
        when(
            mockGetTopRatedMovies.execute()
        ).thenAnswer((_) async => Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (MovieTopRatedBloc bloc) => bloc.add(const MovieTopRatedEvent()),
      expect: () => [
        MovieTopRatedState.initial(),
        const MovieTopRatedState(
          movieState: ErrorUiState('Failed')
        ),
      ],
    );
  });
}
