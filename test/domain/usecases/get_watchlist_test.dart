import 'package:dartz/dartz.dart';
import 'package:core/domain/usecase/get_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../core/test/dummy_data/movies/dummy_objects.dart';
import '../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlist(mockMovieRepository);
  });

  test('should get list of movies from the repository', () async {
    // watchlist
    // arrange
    when(mockMovieRepository.getWatchlistMovies())
        .thenAnswer((_) async => Right(testWatchList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testWatchList));
  });
}
