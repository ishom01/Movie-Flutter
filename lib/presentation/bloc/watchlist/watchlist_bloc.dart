import 'package:core/common/data_state.dart';
import 'package:core/domain/usecase/get_watchlist.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_event.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistBloc extends Bloc<WatchListEvent, WatchlistState> {
  final GetWatchlist watchlist;

  WatchlistBloc(this.watchlist): super(WatchlistState.initial()) {

    on<WatchListEvent>((event, emit) async {
       emit(state.copyWith(watchListState: const LoadingUiState()));
       final result = await watchlist.execute();
       result.fold(
         (failed) => emit(state.copyWith(
             watchListState: ErrorUiState(failed.message))),
         (success) => emit(state.copyWith(
             watchListState: SuccessUiState(success)))
       );
    });
  }
}