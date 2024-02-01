import 'package:dartz/dartz.dart';
import '../../../tv_series/lib/domain/usecase/get_now_playing_series.dart';
import '../../../tv_series/lib/domain/usecase/get_series_episode.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_series/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

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
