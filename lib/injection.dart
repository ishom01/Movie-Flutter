import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => WatchlistBloc(locator()));
}
