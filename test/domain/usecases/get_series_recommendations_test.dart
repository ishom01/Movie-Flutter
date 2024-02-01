import 'package:dartz/dartz.dart';
import '../../../tv_series/lib/domain/usecase/get_now_playing_series.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_series/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetSeriesRecommendations(mockTvSeriesRepository);
  });

  var series = testSeriesList.map((e) => e.toEntity()).toList();
  var id = 1;

  test('should get list of series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getSeriesRecommendations(id))
        .thenAnswer((_) async =>
        Right(series));
    // act
    final result = await usecase.execute(id);
    // assert
    expect(result, Right(series));
  });
}
