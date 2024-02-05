import 'package:dartz/dartz.dart';
import 'package:core/domain/usecase/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test/dummy_data/movies/dummy_objects.dart';
import '../../../test/dummy_data/tv_series/dummy_objects.dart';
import '../../../test/helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveWatchlist(mockMovieRepository, mockTvSeriesRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.removeMovie(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeWatchlist(testMovieDetail));
    expect(result, const Right('Removed from watchlist'));
  });

  test('should remove watchlist series from repository', () async {
    var seriesDetail = testSeriesDetail.toEntity();

    // arrange
    when(mockTvSeriesRepository.removeWatchlist(seriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.removeSeries(seriesDetail);
    // assert
    verify(mockTvSeriesRepository.removeWatchlist(seriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
