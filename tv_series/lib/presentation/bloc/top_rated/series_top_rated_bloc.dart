import 'package:core/common/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecase/get_top_rated_series.dart';
import 'package:tv_series/presentation/bloc/top_rated/series_top_rated_event.dart';
import 'package:tv_series/presentation/bloc/top_rated/series_top_rated_state.dart';

class SeriesTopRatedBloc
    extends Bloc<SeriesTopRatedEvent, SeriesTopRatedState> {

  final GetTopRatedSeries topRatedSeries;

  SeriesTopRatedBloc(
    this.topRatedSeries,
  ): super(SeriesTopRatedState.initial()) {

    on<SeriesTopRatedEvent>((event, emit) async {
      emit(state.copyWith(seriesState: const LoadingUiState()));
      final result = await topRatedSeries.execute();
      result.fold(
        (failed) => emit(state.copyWith(
            seriesState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            seriesState: SuccessUiState(success))),
      );
    });
  }
}