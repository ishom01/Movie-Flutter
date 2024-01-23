import 'package:ditonton/common/home_enum.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_series_episode.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetSeriesEpisodes getSeriesEpisodes;
  final GetSeriesRecommendations getSeriesRecommendations;
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  SeriesDetailNotifier({
    required this.getSeriesEpisodes,
    required this.getSeriesRecommendations,
    required this.getTvSeriesDetail,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist
  });

  late TvSeriesDetail _detail;

  TvSeriesDetail get detail => _detail;

  RequestState _seriesState = RequestState.Empty;
  RequestState get seriesState => _seriesState;

  List<TvSeries> _seriesRecommendations = [];
  List<TvSeries> get seriesRecommendations => _seriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  Map<Season, List<Episode>> _seasonMaps = {};
  Map<Season, List<Episode>> get seasonMaps => _seasonMaps;

  RequestState _seasonsState = RequestState.Empty;
  RequestState get seasonState => _seasonsState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchSeriesDetail(int id) async {
    _seriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _seriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (series) async {
        _recommendationState = RequestState.Loading;
        _seasonsState = RequestState.Loading;
        _seriesState = RequestState.Loaded;
        _detail = series;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          },
          (seriesList) {
            _recommendationState = RequestState.Loaded;
            _seriesRecommendations = seriesList;
            notifyListeners();
          },
        );

        final episodeResult = await getSeriesEpisodes.execute(series);
        episodeResult.fold(
          (failure) {
            _seasonsState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          },
          (seasonMaps) {
            _seasonsState = RequestState.Loaded;
            _seasonMaps = seasonMaps;
            notifyListeners();
          },
        );
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvSeriesDetail seriesDetail) async {
    final result = await saveWatchlist.saveSeries(seriesDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(seriesDetail.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail seriesDetail) async {
    final result = await removeWatchlist.removeSeries(seriesDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(seriesDetail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id, DataType.TvSeries);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
