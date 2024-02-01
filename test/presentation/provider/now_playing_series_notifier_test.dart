import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import '../../../tv_series/lib/domain/usecase/get_now_playing_series.dart';
import 'package:ditonton/presentation/provider/now_playing_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_series/dummy_objects.dart';
import 'now_playing_series_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingSeries])
void main() {
  late MockGetNowPlayingSeries mockNowPlayingSeries;
  late NowPlayingSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockNowPlayingSeries = MockGetNowPlayingSeries();
    notifier = NowPlayingSeriesNotifier(mockNowPlayingSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tMovieList = testSeriesList.map((e) => e.toEntity()).toList();

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockNowPlayingSeries.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    notifier.fetchPopularSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockNowPlayingSeries.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    await notifier.fetchPopularSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.series, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockNowPlayingSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
