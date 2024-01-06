import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:flutter/cupertino.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _nowPlayingSeries= <TvSeries>[];

  List<TvSeries> get nowPlayingSeries => _nowPlayingSeries;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularSeries = <TvSeries>[];
  List<TvSeries> get popularSeries => _popularSeries;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRatedSeries = <TvSeries>[];
  List<TvSeries> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedSeriesState = RequestState.Empty;
  RequestState get topRatedSeriesState => _topRatedSeriesState;

  String _message  = '';
  String get message => _message;

  final GetNowPlayingSeries getNowPlayingSeries;
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;

  TvSeriesListNotifier({
    required this.getNowPlayingSeries,
    required this.getPopularSeries,
    required this.getTopRatedSeries
  });

  Future<void> fetchNowPlayingSeries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (series) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingSeries = series;
        notifyListeners();
      }
    );
  }

  Future<void> fetchPopularSeries() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (series) {
        _popularState = RequestState.Loaded;
        _popularSeries = series;
        notifyListeners();
      }
    );
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();
    result.fold(
      (failure) {
        _topRatedSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (series) {
        _topRatedSeriesState = RequestState.Loaded;
        _topRatedSeries = series;
        notifyListeners();
      }
    );
  }
}