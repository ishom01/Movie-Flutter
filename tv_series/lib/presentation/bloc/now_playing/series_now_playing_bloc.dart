import 'package:core/common/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecase/get_now_playing_series.dart';
import 'package:tv_series/presentation/bloc/now_playing/series_now_playing_event.dart';
import 'package:tv_series/presentation/bloc/now_playing/series_now_playing_state.dart';

class SeriesNowPlayingBloc
    extends Bloc<SeriesNowPlayingEvent, SeriesNowPlayingState> {

  final GetNowPlayingSeries nowPlayingSeries;

  SeriesNowPlayingBloc(
    this.nowPlayingSeries,
  ): super(SeriesNowPlayingState.initial()) {

    on<SeriesNowPlayingEvent>((event, emit) async {
      emit(state.copyWith(seriesState: const LoadingUiState()));
      final result = await nowPlayingSeries.execute();
      result.fold(
        (failed) => emit(state.copyWith(
            seriesState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            seriesState: SuccessUiState(success))),
      );
    });
  }
}