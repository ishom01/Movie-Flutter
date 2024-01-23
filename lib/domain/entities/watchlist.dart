import 'package:equatable/equatable.dart';

class Watchlist extends Equatable {

  Watchlist({
    required this.id,
    required this.title,
    required this.path,
    required this.overview,
    required this.type,
  });

  int id;
  String? path;
  String? title;
  String? overview;
  int? type;

  @override
  List<Object?> get props => [
    id,
    path,
    title,
    overview,
    type
  ];
}