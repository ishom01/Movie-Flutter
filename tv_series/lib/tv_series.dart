library tv_series;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tv_series/domain/usecase/get_now_playing_series.dart';
import 'package:tv_series/domain/usecase/get_popular_series.dart';
import 'package:tv_series/domain/usecase/get_series_episode.dart';
import 'package:tv_series/domain/usecase/get_series_recommendations.dart';
import 'package:tv_series/domain/usecase/get_top_rated_series.dart';
import 'package:tv_series/domain/usecase/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecase/search_series.dart';
import 'package:tv_series/presentation/bloc/detail/series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/main/series_main_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing/series_now_playing_bloc.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/search/series_search_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated/series_top_rated_bloc.dart';

final blocProvides = <SingleChildWidget>[];
final locator = GetIt.instance;

void init() {
  _initDependencies();
  blocProvides.addAll([
     BlocProvider(create: (_) => locator<SeriesDetailBloc>()),
     BlocProvider(create: (_) => locator<SeriesMainBloc>()),
     BlocProvider(create: (_) => locator<SeriesNowPlayingBloc>()),
     BlocProvider(create: (_) => locator<SeriesPopularBloc>()),
     BlocProvider(create: (_) => locator<SeriesSearchBloc>()),
     BlocProvider(create: (_) => locator<SeriesTopRatedBloc>()),
  ]);
}

void _initDependencies() {
   locator.registerFactory(() => SeriesDetailBloc(
       locator(),
       locator(),
       locator(),
       locator(),
       locator(),
       locator()
   ));
   locator.registerFactory(() => SeriesMainBloc(
       locator(), locator(), locator()
   ));
   locator.registerFactory(() => SeriesNowPlayingBloc(locator()));
   locator.registerFactory(() => SeriesPopularBloc(locator()));
   locator.registerFactory(() => SeriesSearchBloc(locator()));
   locator.registerFactory(() => SeriesTopRatedBloc(locator()));

  locator.registerLazySingleton(() => GetNowPlayingSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesEpisodes(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
}