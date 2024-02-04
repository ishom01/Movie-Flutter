import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/usecase/get_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/test/dummy_data/tv_series/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

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
