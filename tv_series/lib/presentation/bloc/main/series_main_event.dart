import 'package:equatable/equatable.dart';

abstract class SeriesMainEvent extends Equatable {

  const SeriesMainEvent();

  @override
  List<Object?> get props => [];
}

class SeriesMainPopularEvent extends SeriesMainEvent {

  const SeriesMainPopularEvent();

  @override
  List<Object?> get props => [];
}

class SeriesMainTopRatedEvent extends SeriesMainEvent {

  const SeriesMainTopRatedEvent();

  @override
  List<Object?> get props => [];
}

class SeriesMainNowPlayingEvent extends SeriesMainEvent {

  const SeriesMainNowPlayingEvent();

  @override
  List<Object?> get props => [];
}