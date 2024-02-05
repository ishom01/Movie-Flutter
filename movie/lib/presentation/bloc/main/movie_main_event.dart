import 'package:equatable/equatable.dart';

abstract class MovieMainEvent extends Equatable {

  const MovieMainEvent();

  @override
  List<Object?> get props => [];
}

class MovieMainPopularEvent extends MovieMainEvent {

  const MovieMainPopularEvent();

  @override
  List<Object?> get props => [];
}

class MovieMainTopRatedEvent extends MovieMainEvent {

  const MovieMainTopRatedEvent();

  @override
  List<Object?> get props => [];
}

class MovieMainNowPlayingEvent extends MovieMainEvent {

  const MovieMainNowPlayingEvent();

  @override
  List<Object?> get props => [];
}