import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:ditonton/presentation/provider/series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_series/dummy_objects.dart';
import 'series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late MockSearchSeries mockSearchSeries;
  late SeriesSearchNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchSeries = MockSearchSeries();
    notifier = SeriesSearchNotifier(searchSeries: mockSearchSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tMovieList = testSeriesList.map((e) => e.toEntity()).toList();
  final query = "spiderman";

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockSearchSeries.execute(query))
        .thenAnswer((_) async => Right(tMovieList));
    // act
    notifier.fetchSeriesSearch(query);
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockSearchSeries.execute(query))
        .thenAnswer((_) async => Right(tMovieList));
    // act
    await notifier.fetchSeriesSearch(query);
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.searchResult, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockSearchSeries.execute(query))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchSeriesSearch(query);
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
