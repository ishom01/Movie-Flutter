library movie;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/main/movie_main_bloc.dart';
import 'package:movie/presentation/bloc/popular/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/search/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/movie_top_rated_bloc.dart';
import 'package:provider/single_child_widget.dart';

import 'domain/usecase/get_movie_detail.dart';
import 'domain/usecase/get_movie_recommendations.dart';
import 'domain/usecase/get_now_playing_movies.dart';
import 'domain/usecase/get_popular_movies.dart';
import 'domain/usecase/get_top_rated_movies.dart';
import 'domain/usecase/search_movies.dart';

final blocProvides = <SingleChildWidget>[];
final locator = GetIt.instance;

void init() {
  _initDependencies();
  blocProvides.addAll([
    BlocProvider(create: (_) => locator<MovieDetailBloc>()),
    BlocProvider(create: (_) => locator<MovieMainBloc>()),
    BlocProvider(create: (_) => locator<MoviePopularBloc>()),
    BlocProvider(create: (_) => locator<MovieSearchBloc>()),
    BlocProvider(create: (_) => locator<MovieTopRatedBloc>()),
  ]);
}

void _initDependencies() {
  locator.registerFactory(() => MovieDetailBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator()
  ));
  locator.registerFactory(() => MovieMainBloc(locator(), locator(), locator()));
  locator.registerFactory(() => MoviePopularBloc(locator()));
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(() => MovieTopRatedBloc(locator()));

  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
}


