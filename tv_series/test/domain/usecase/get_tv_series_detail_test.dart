import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/usecase/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/test/dummy_data/tv_series/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  var seriesDetail = testSeriesDetail.toEntity();
  var id = 1;

  test('should get list of series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getSeriesDetail(id))
        .thenAnswer((_) async =>
        Right(seriesDetail));
    // act
    final result = await usecase.execute(id);
    // assert
    expect(result, Right(seriesDetail));
  });
}
