import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/movies/dummy_objects.dart';
import '../../dummy_data/tv_series/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlist(mockMovieRepository,mockTvSeriesRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.saveMovie(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveWatchlist(testMovieDetail));
    expect(result, Right('Added to Watchlist'));
  });

  test('should save series to the repository', () async {
    var seriesDetailEntity = testSeriesDetail.toEntity();

    // arrange
    when(mockTvSeriesRepository.saveWatchlist(seriesDetailEntity))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.saveSeries(seriesDetailEntity);
    // assert
    verify(mockTvSeriesRepository.saveWatchlist(seriesDetailEntity));
    expect(result, Right('Added to Watchlist'));
  });
}
