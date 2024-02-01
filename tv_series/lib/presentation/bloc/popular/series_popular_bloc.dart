import 'package:core/common/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecase/get_popular_series.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_event.dart';
import 'package:tv_series/presentation/bloc/popular/series_popular_state.dart';

class SeriesPopularBloc extends Bloc<SeriesPopularEvent, SeriesPopularState> {

  final GetPopularSeries popularSeries;

  SeriesPopularBloc(
    this.popularSeries,
  ): super(SeriesPopularState.initial()) {

    on<SeriesPopularEvent>((event, emit) async {
      emit(state.copyWith(seriesState: const LoadingUiState()));
      final result = await popularSeries.execute();
      result.fold(
        (failed) => emit(state.copyWith(
            seriesState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            seriesState: SuccessUiState(success))),
      );
    });
  }
}