import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/data_state.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecase/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/popular/movie_popular_event.dart';
import 'package:movie/presentation/bloc/popular/movie_popular_state.dart';

import 'movie_domain_test.mocks.dart';

@GenerateMocks([
  GetPopularMovies,
])
void main() {
  late MoviePopularBloc bloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = MoviePopularBloc(
      mockGetPopularMovies,
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

  group('Get Movie Popular', () {
    blocTest<MoviePopularBloc, MoviePopularState>(
      "should get main usecase completed",
      build: () {
        when(
          mockGetPopularMovies.execute()
        ).thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (MoviePopularBloc bloc) => bloc.add(const MoviePopularEvent()),
      expect: () => [
        MoviePopularState.initial(),
        MoviePopularState(
          movieState: SuccessUiState(tMovies),
        ),
      ],
    );

    blocTest<MoviePopularBloc, MoviePopularState>(
      "should get main usecase but failed all",
      build: () {
        when(
            mockGetPopularMovies.execute()
        ).thenAnswer((_) async => Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (MoviePopularBloc bloc) => bloc.add(const MoviePopularEvent()),
      expect: () => [
        MoviePopularState.initial(),
        const MoviePopularState(
          movieState: ErrorUiState('Failed')
        ),
      ],
    );
  });
}
