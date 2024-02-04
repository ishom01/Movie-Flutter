library core;

import 'package:core/domain/usecase/get_watchlist.dart';
import 'package:core/domain/usecase/get_watchlist_status.dart';
import 'package:core/domain/usecase/remove_watchlist.dart';
import 'package:core/domain/usecase/save_watchlist.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/repositories/movie_repository_impl.dart';
import 'data/repositories/tv_series_repository_impl.dart';
import 'data/sources/db/database_helper.dart';
import 'data/sources/movie_remote_data_source.dart';
import 'data/sources/tv_series_remote_data_source.dart';
import 'data/sources/watch_list_local_data_source.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/repositories/tv_series_repository.dart';

final locator = GetIt.instance;

void init() {
  // usecase
  locator.registerLazySingleton<GetWatchlist>(() => GetWatchlist(
    locator(),
  ));
  locator.registerLazySingleton<SaveWatchlist>(() => SaveWatchlist(
      locator(),
      locator(),
  ));
  locator.registerLazySingleton<RemoveWatchlist>(() => RemoveWatchlist(
    locator(),
    locator(),
  ));
  locator.registerLazySingleton<GetWatchListStatus>(() => GetWatchListStatus(
    locator(),
    locator(),
  ));

  // repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
        () => TvSeriesRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator()
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<WatchListLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
          () => TvSeriesRemoteDataSourceImpl(client: locator())
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}