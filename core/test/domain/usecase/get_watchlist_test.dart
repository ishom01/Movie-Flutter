import 'package:core/common/failure.dart';
import 'package:core/common/home_enum.dart';
import 'package:core/domain/usecase/get_watchlist.dart';
import 'package:core/domain/usecase/get_watchlist_status.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test/helpers/test_helper.mocks.dart';
import '../../dummy_data/movies/dummy_objects.dart';

void main() {
  late GetWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlist(mockMovieRepository);
  });

  test('should get watchlist list', () async {
    // arrange
    when(mockMovieRepository.getWatchlistMovies())
        .thenAnswer((_) async => Right(testWatchList));
    // act
    final result = await usecase.execute();
    verify(mockMovieRepository.getWatchlistMovies());
    // assert
    expect(result, Right(testWatchList));
  });

  test('should error get watchlist list', () async {
    // arrange
    when(mockMovieRepository.getWatchlistMovies())
        .thenAnswer((_) async => Left(ServerFailure('Error')));
    // act
    final result = await usecase.execute();
    verify(mockMovieRepository.getWatchlistMovies());
    // assert
    expect(result, Left(ServerFailure('Error')));
  });
}
