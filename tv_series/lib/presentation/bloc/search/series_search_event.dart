import 'package:equatable/equatable.dart';

class SeriesSearchEvent extends Equatable {

  final String key;

  const SeriesSearchEvent(this.key);

  @override
  List<Object?> get props => [
    key,
  ];
}