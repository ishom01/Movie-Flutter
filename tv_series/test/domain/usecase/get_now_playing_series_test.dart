import 'package:dartz/dartz.dart';
import '../../../lib/domain/usecase/get_now_playing_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/test/dummy_data/tv_series/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetNowPlayingSeries(mockTvSeriesRepository);
  });

  var series = testSeriesList.map((e) => e.toEntity()).toList();

  test('should get list of series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getNowPlayingSeries())
        .thenAnswer((_) async =>
        Right(series));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(series));
  });
}
