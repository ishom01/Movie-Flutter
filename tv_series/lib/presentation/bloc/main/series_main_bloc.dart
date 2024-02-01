import 'package:core/common/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecase/get_now_playing_series.dart';
import 'package:tv_series/domain/usecase/get_popular_series.dart';
import 'package:tv_series/domain/usecase/get_top_rated_series.dart';
import 'package:tv_series/presentation/bloc/main/series_main_event.dart';
import 'package:tv_series/presentation/bloc/main/series_main_state.dart';

class SeriesMainBloc extends Bloc<SeriesMainEvent, SeriesMainState> {

  final GetPopularSeries popularSeries;
  final GetNowPlayingSeries nowPlayingSeries;
  final GetTopRatedSeries topRatedSeries;

  SeriesMainBloc(
    this.popularSeries,
    this.nowPlayingSeries,
    this.topRatedSeries,
  ): super(SeriesMainState.initial()) {

    on<SeriesMainPopularEvent>((event, emit) async {
      emit(state.copyWith(popularState: const LoadingUiState()));
      final result = await popularSeries.execute();
      result.fold(
        (failed) => emit(state.copyWith(
            popularState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            popularState: SuccessUiState(success))),
      );
    });

    on<SeriesMainTopRatedEvent>((event, emit) async {
      emit(state.copyWith(topRatedState: const LoadingUiState()));
      final result = await topRatedSeries.execute();
      result.fold(
        (failed) => emit(state.copyWith(
            topRatedState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            topRatedState: SuccessUiState(success))),
      );
    });

    on<SeriesMainNowPlayingEvent>((event, emit) async {
      emit(state.copyWith(nowPlayingState: const LoadingUiState()));
      final result = await nowPlayingSeries.execute();
      result.fold(
        (failed) => emit(state.copyWith(
            nowPlayingState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            nowPlayingState: SuccessUiState(success))),
      );
    });
  }
}