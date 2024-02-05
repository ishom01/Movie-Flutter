import 'package:core/common/data_state.dart';
import 'package:core/domain/entities/watchlist.dart';
import 'package:equatable/equatable.dart';

class WatchlistState extends Equatable {
  final UiState<List<Watchlist>> watchListState;

  WatchlistState({required this.watchListState});

  @override
  List<Object?> get props => [
    watchListState
  ];

  WatchlistState copyWith({
    UiState<List<Watchlist>>? watchListState,
  }) {
    return WatchlistState(
      watchListState: watchListState ?? this.watchListState,
    );
  }

  factory WatchlistState.initial() {
    return WatchlistState(
      watchListState: LoadingUiState(),
    );
  }
}