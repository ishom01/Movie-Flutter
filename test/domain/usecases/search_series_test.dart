import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_series/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = SearchSeries(mockRepository);
  });

  var series = testSeriesList.map((e) => e.toEntity()).toList();
  final tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockRepository.searchSeries(tQuery))
        .thenAnswer((_) async => Right(series));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(series));
  });
}
