import 'package:equatable/equatable.dart';

class UiState<T> extends Equatable {

  final bool isLoading;
  final bool isError;
  final String? message;
  final T? data;

  const UiState({
    required this.isLoading,
    required this.isError,
    required this.message,
    required this.data
  });

  @override
  List<Object?> get props => [];
}

class LoadingUiState<T> extends UiState<T> {
  const LoadingUiState() : super(
    isLoading: true,
    isError: false,
    message: null,
    data: null
  );
}

class ErrorUiState<T> extends UiState<T> {
  const ErrorUiState(
    String message,
  ) : super(
    isLoading: false,
    isError: true,
    message: message,
    data: null
  );
}

class SuccessUiState<T> extends UiState<T> {
  const SuccessUiState(
    T data,
  ) : super(
    isLoading: false,
    isError: false,
    message: null,
    data: data
  );
}