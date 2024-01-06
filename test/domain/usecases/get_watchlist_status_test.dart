import 'package:ditonton/common/home_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatus usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchListStatus(mockMovieRepository, mockTvSeriesRepository);
  });

  test('should get watchlist status from movie', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1, DataType.Movie);
    verify(mockMovieRepository.isAddedToWatchlist(1));
    // assert
    expect(result, true);
  });

  test('should get watchlist status from tvseries', () async {
    // arrange
    when(mockTvSeriesRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1, DataType.TvSeries);
    verify(mockTvSeriesRepository.isAddedToWatchlist(1));
    // assert
    expect(result, true);
  });
}
