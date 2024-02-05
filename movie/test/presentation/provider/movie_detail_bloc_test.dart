import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/data_state.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/home_enum.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecase/get_watchlist_status.dart';
import 'package:core/domain/usecase/remove_watchlist.dart';
import 'package:core/domain/usecase/save_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecase/get_movie_detail.dart';
import 'package:movie/domain/usecase/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/detail/movie_detail_event.dart';
import 'package:movie/presentation/bloc/detail/movie_detail_state.dart';

import '../../../../core/test/dummy_data/movies/dummy_objects.dart';
import 'movie_domain_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
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

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      "should get data from usecase until complete",
      build: () {
        when(
          mockGetMovieDetail.execute(tId)
        ).thenAnswer((_) async => Right(testMovieDetail));
        when(
            mockGetWatchlistStatus.execute(tId, DataType.Movie)
        ).thenAnswer((_) async => true);
        when(
            mockGetMovieRecommendations.execute(tId)
        ).thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (MovieDetailBloc bloc) => bloc
        ..add(const FetchMovieDetailEvent(tId))
        ..add(const FetchRecommendationMovieDetailEvent(tId)),
      expect: () => [
        MovieDetailState.initial(),
        MovieDetailState(
          movieState: SuccessUiState(testMovieDetail),
          recommendationState: const LoadingUiState(),
          isAddedFavorite: false
        ),
        MovieDetailState(
            movieState: SuccessUiState(testMovieDetail),
            recommendationState: SuccessUiState(tMovies),
            isAddedFavorite: false
        ),
        MovieDetailState(
            movieState: SuccessUiState(testMovieDetail),
            recommendationState: SuccessUiState(tMovies),
            isAddedFavorite: true
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should get data from usecase but recommended failed",
      build: () {
        when(
            mockGetMovieDetail.execute(tId)
        ).thenAnswer((_) async => Right(testMovieDetail));
        when(
            mockGetWatchlistStatus.execute(tId, DataType.Movie)
        ).thenAnswer((_) async => true);
        when(
            mockGetMovieRecommendations.execute(tId)
        ).thenAnswer((_) async => Left(ServerFailure('failed message')));
        return bloc;
      },
      act: (MovieDetailBloc bloc) => bloc
        ..add(const FetchMovieDetailEvent(tId))
        ..add(const FetchRecommendationMovieDetailEvent(tId)),
      expect: () => [
        MovieDetailState.initial(),
        MovieDetailState(
            movieState: SuccessUiState(testMovieDetail),
            recommendationState: const LoadingUiState(),
            isAddedFavorite: false
        ),
        MovieDetailState(
            movieState: SuccessUiState(testMovieDetail),
            recommendationState: const ErrorUiState('failed message'),
            isAddedFavorite: false,
        ),
        MovieDetailState(
            movieState: SuccessUiState(testMovieDetail),
            recommendationState: const ErrorUiState('failed message'),
            isAddedFavorite: true,
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should get data from usecase failed",
      build: () {
        when(
            mockGetMovieDetail.execute(tId)
        ).thenAnswer((_) async => Left(ServerFailure('failed message')));
        when(
            mockGetWatchlistStatus.execute(tId, DataType.Movie)
        ).thenAnswer((_) async => true);
        when(
            mockGetMovieRecommendations.execute(tId)
        ).thenAnswer((_) async => Left(ServerFailure('failed message')));
        return bloc;
      },
      act: (MovieDetailBloc bloc) => bloc
        ..add(const FetchMovieDetailEvent(tId))
        ..add(const FetchRecommendationMovieDetailEvent(tId)),
      expect: () => [
        MovieDetailState.initial(),
        const MovieDetailState(
            movieState: ErrorUiState('failed message'),
            recommendationState: LoadingUiState(),
            isAddedFavorite: false
        ),
        const MovieDetailState(
            movieState: ErrorUiState('failed message'),
            recommendationState: ErrorUiState('failed message'),
            isAddedFavorite: false
        ),
        const MovieDetailState(
            movieState: ErrorUiState('failed message'),
            recommendationState: ErrorUiState('failed message'),
            isAddedFavorite: true
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should save usecase detail",
      build: () {
        when(mockSaveWatchlist.saveMovie(testMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id, DataType.Movie))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (MovieDetailBloc bloc) => bloc
        .add(ChangeWatchlistDetailEvent(true, testMovieDetail)),
      expect: () => [
        const MovieDetailState(
            movieState: LoadingUiState(),
            recommendationState: LoadingUiState(),
            isAddedFavorite: true
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should save usecase detail but failed",
      build: () {
        when(mockSaveWatchlist.saveMovie(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        return bloc;
      },
      act: (MovieDetailBloc bloc) => bloc
          .add(ChangeWatchlistDetailEvent(true, testMovieDetail)),
      expect: () => [
        const MovieDetailState(
            movieState: LoadingUiState(),
            recommendationState: LoadingUiState(),
            isAddedFavorite: true
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should remove usecase detail",
      build: () {
        when(mockRemoveWatchlist.removeMovie(testMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id, DataType.Movie))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (MovieDetailBloc bloc) => bloc
          .add(ChangeWatchlistDetailEvent(false, testMovieDetail)),
      expect: () => [
        const MovieDetailState(
            movieState: LoadingUiState(),
            recommendationState: LoadingUiState(),
            isAddedFavorite: false
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should remove usecase detail but failed",
      build: () {
        when(mockRemoveWatchlist.removeMovie(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id, DataType.Movie))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (MovieDetailBloc bloc) => bloc
          .add(ChangeWatchlistDetailEvent(false, testMovieDetail)),
      expect: () => [
        const MovieDetailState(
            movieState: LoadingUiState(),
            recommendationState: LoadingUiState(),
            isAddedFavorite: false
        ),
      ],
    );
  });
}
