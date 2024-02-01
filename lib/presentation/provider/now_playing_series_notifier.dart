import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import '../../../tv_series/lib/domain/usecase/get_now_playing_series.dart';
import '../../../tv_series/lib/domain/usecase/get_popular_series.dart';
import 'package:flutter/cupertino.dart';

class NowPlayingSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingSeries getNowPlayingSeries;

  NowPlayingSeriesNotifier(this.getNowPlayingSeries);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvSeries> _series = [];
  List<TvSeries> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingSeries.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      }, (series) {
        _series = series;
        _state = RequestState.Loaded;
        notifyListeners();
    });
  }
}