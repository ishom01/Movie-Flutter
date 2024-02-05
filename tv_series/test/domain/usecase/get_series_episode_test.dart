import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_series_episode.dart';

import '../../../../core/test/dummy_data/tv_series/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesEpisodes usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetSeriesEpisodes(mockTvSeriesRepository);
  });

  final episodeMaps = {
    tvSeriesSeason.toEntity(): tvEpisodes.map((e) => e.toEntity()).toList(),
    tvSeriesSeason2.toEntity(): tvEpisodes.map((e) => e.toEntity()).toList()
  };
  final id = 1;


  test('should get list of episode from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getEpisodes(id))
        .thenAnswer((_) async =>
        Right(episodeMaps));
    // act
    final result = await usecase.execute(id);
    // assert
    expect(result, Right(episodeMaps));
  });
}
