import 'package:flutter/material.dart';
import '../../common/data_state.dart';

typedef SuccessBuilder<T> = Widget Function(
    T data,
);

class StateContent<T> extends StatelessWidget {

  final UiState<T> state;
  final SuccessBuilder<T> builder;

  const StateContent({
    super.key,
    required this.state,
    required this.builder
  });

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.isError) {
      return Text(state.message ?? "");
    } else {
      return builder(state.data as T);
    }
  }
}