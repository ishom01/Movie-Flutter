import 'package:core/common/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecase/search_series.dart';
import 'package:tv_series/presentation/bloc/search/series_search_event.dart';
import 'package:tv_series/presentation/bloc/search/series_search_state.dart';

class SeriesSearchBloc
    extends Bloc<SeriesSearchEvent, SeriesSearchState> {

  final SearchSeries searchSeries;

  SeriesSearchBloc(
    this.searchSeries,
  ): super(SeriesSearchState.initial()) {

    on<SeriesSearchEvent>((event, emit) async {
      emit(state.copyWith(seriesState: const LoadingUiState()));
      final result = await searchSeries.execute(event.key);
      result.fold(
        (failed) => emit(state.copyWith(
            seriesState: ErrorUiState(failed.message))),
        (success) => emit(state.copyWith(
            seriesState: SuccessUiState(success))),
      );
    });
  }
}