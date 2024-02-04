import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/data_state.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecase/get_now_playing_movies.dart';
import 'package:movie/domain/usecase/get_popular_movies.dart';
import 'package:movie/domain/usecase/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/main/movie_main_bloc.dart';
import 'package:movie/presentation/bloc/main/movie_main_event.dart';
import 'package:movie/presentation/bloc/main/movie_main_state.dart';

import 'movie_domain_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
])
void main() {
  late MovieMainBloc bloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = MovieMainBloc(
      mockGetPopularMovies,
      mockGetNowPlayingMovies,
      mockGetTopRatedMovies,
    );
  });

  const tId = 1;

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

  group('Get Movie Main', () {
    blocTest<MovieMainBloc, MovieMainState>(
      "should get main usecase completed",
      build: () {
        when(
          mockGetNowPlayingMovies.execute()
        ).thenAnswer((_) async => Right(tMovies));
        when(
          mockGetPopularMovies.execute()
        ).thenAnswer((_) async => Right(tMovies));
        when(
          mockGetTopRatedMovies.execute()
        ).thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (MovieMainBloc bloc) => bloc
        ..add(const MovieMainPopularEvent())
        ..add(const MovieMainNowPlayingEvent())
        ..add(const MovieMainTopRatedEvent()),
      expect: () => [
        MovieMainState(
          popularState: SuccessUiState(tMovies),
          nowPlayingState: const LoadingUiState(),
          topRatedState: const LoadingUiState(),
        ),
        MovieMainState(
          popularState: SuccessUiState(tMovies),
          nowPlayingState: SuccessUiState(tMovies),
          topRatedState: const LoadingUiState(),
        ),
        MovieMainState(
          popularState: SuccessUiState(tMovies),
          nowPlayingState: SuccessUiState(tMovies),
          topRatedState: SuccessUiState(tMovies),
        ),
      ],
    );

    blocTest<MovieMainBloc, MovieMainState>(
      "should get main usecase but failed all",
      build: () {
        when(
            mockGetNowPlayingMovies.execute()
        ).thenAnswer((_) async => Left(ServerFailure('Failed')));
        when(
            mockGetPopularMovies.execute()
        ).thenAnswer((_) async => Left(ServerFailure('Failed')));
        when(
            mockGetTopRatedMovies.execute()
        ).thenAnswer((_) async => Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (MovieMainBloc bloc) => bloc
        ..add(const MovieMainPopularEvent())
        ..add(const MovieMainNowPlayingEvent())
        ..add(const MovieMainTopRatedEvent()),
      expect: () => [
        const MovieMainState(
          popularState: ErrorUiState('Failed'),
          nowPlayingState: LoadingUiState(),
          topRatedState: LoadingUiState(),
        ),
        const MovieMainState(
          popularState: ErrorUiState('Failed'),
          nowPlayingState: ErrorUiState('Failed'),
          topRatedState: LoadingUiState(),
        ),
        const MovieMainState(
          popularState: ErrorUiState('Failed'),
          nowPlayingState: ErrorUiState('Failed'),
          topRatedState: ErrorUiState('Failed'),
        ),
      ],
    );
  });
}
