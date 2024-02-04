import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/data_state.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecase/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/search/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/search/movie_search_event.dart';
import 'package:movie/presentation/bloc/search/movie_search_state.dart';

import 'movie_domain_test.mocks.dart';

@GenerateMocks([
  GetTopRatedMovies,
])
void main() {
  late MovieSearchBloc bloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = MovieSearchBloc(
      mockSearchMovies,
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
  const key = "Search";

  group('Get Movie Search', () {
    blocTest<MovieSearchBloc, MovieSearchState>(
      "should get main usecase completed",
      build: () {
        when(
          mockSearchMovies.execute(key)
        ).thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (MovieSearchBloc bloc) => bloc.add(MovieSearchEvent(key)),
      expect: () => [
        const MovieSearchState(
          key: key,
          movieState: LoadingUiState(),
        ),
        MovieSearchState(
          key: key,
          movieState: SuccessUiState(tMovies),
        ),
      ],
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      "should get main usecase but failed all",
      build: () {
        when(
            mockSearchMovies.execute(key)
        ).thenAnswer((_) async => Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (MovieSearchBloc bloc) => bloc.add(const MovieSearchEvent(key)),
      expect: () => [
        const MovieSearchState(
            key: key,
            movieState: LoadingUiState(),
        ),
        const MovieSearchState(
          key: key,
          movieState: ErrorUiState('Failed')
        ),
      ],
    );
  });
}
